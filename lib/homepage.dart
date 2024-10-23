import 'package:flutter/material.dart';
import 'career page.dart';
import 'career_support.dart';
import 'about_page.dart';
import 'teacher_detail_page.dart';
import 'group.dart';
import 'profile.dart';
import 'mail.dart';
import 'response.dart';
import 'upload_teacher_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final bool isAdmin;

  const HomePage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      TeachersPage(),
      CareerPage(isAdmin: widget.isAdmin),
      const GroupPage(), // Pass isAdmin to GroupPage
    ];

    if (!widget.isAdmin) {
      _pages.insert(2, const CareerSupportPage());
    } else {
      _pages.insert(2, const ResponsePage());
    }

    if (widget.isAdmin) {
      _pages.add(ProfilePage());
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _goToAboutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  void _goToMailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MailPage()),
    );
  }

  void _goToUploadPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadTeacherPage()),
    );
  }

  void _onUploadIconTapped() {
    if (widget.isAdmin) {
      _goToUploadPage();
    } else {
      // Optionally handle the case for non-admin users
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'PU Connect',
            style: TextStyle(
              color: Color(0xFF003F63),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.upload, color: Color(0xFF003F63)),
              onPressed: _onUploadIconTapped,
            ),
          IconButton(
            icon: const Icon(Icons.mail_outline, color: Color(0xFF003F63)),
            onPressed: _goToMailPage,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF003F63)),
            onPressed: _goToAboutPage,
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF003F63),
        unselectedItemColor: const Color(0xFF636363),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Teachers',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Research',
          ),
          if (!widget.isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.handshake),
              label: 'Mentor',
            ),
          if (widget.isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'Response',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubs',
          ),
          if (widget.isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
        ],
      ),
    );
  }
}



class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  List<Map<String, dynamic>> _teachers = [];
  List<Map<String, dynamic>> _filteredTeachers = [];
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  Future<void> _fetchTeachers() async {
    setState(() {
      _isLoading = true; // Set loading to true when fetching data
    });
    try {
      final snapshot = await FirebaseFirestore.instance.collection('teachers').get();
      final teachersList = snapshot.docs.map((doc) {
        return {
          'name': doc['name'],
          'image': doc['image'],
          'availability': doc['availability'],
          'cabin': doc['cabin'],
          'description': doc['description'] ?? 'No description available',
        };
      }).toList();

      setState(() {
        _teachers = teachersList;
        _filteredTeachers = teachersList; // Initialize filtered teachers
        _isLoading = false; // Set loading to false after data is fetched
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading to false in case of error
      });
    }
  }

  void _filterTeachers(String query) {
    setState(() {
      _filteredTeachers = _teachers
          .where((teacher) => teacher['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetailPage(Map<String, dynamic> teacher) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherDetailPage(
          name: teacher['name']!,
          image: teacher['image']!,
          availability: teacher['availability']!,
          cabin: teacher['cabin']!,
          description: teacher['description']!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63),
      body: RefreshIndicator(
        onRefresh: _fetchTeachers, // Refresh the teachers list when pulled down
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: _filterTeachers,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search for teachers...',
                        ),
                      ),
                    ),
                    // Reload (finger reload) icon
                    GestureDetector(
                      onTap: _fetchTeachers, // Manually reload teachers when tapped
                      child: const Icon(
                        Icons.refresh, // Reload icon
                        color: Colors.white, // White color for reload icon
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Loading Indicator or Teachers' List
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                        ),
                      )
                    : _filteredTeachers.isEmpty
                        ? const Center(
                            child: Text(
                              'No teacher found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFE64833),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _filteredTeachers.length,
                            itemBuilder: (context, index) {
                              final teacher = _filteredTeachers[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: const Offset(0, 2),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(16.0),
                                    leading: GestureDetector(
                                      onTap: () => _fetchTeachers(), // Reload image on tap
                                      child: CircleAvatar(
                                        radius: 30, // Set the size of the avatar
                                        backgroundColor: Colors.grey[200],
                                        backgroundImage: NetworkImage(teacher['image']!),
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              teacher['name']!,
                                              style: const TextStyle(
                                                color: Color(0xFF003F63),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              teacher['cabin']!,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Blue checkmark icon for availability
                                        if (teacher['availability'] == true)
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                      ],
                                    ),
                                    onTap: () => _navigateToDetailPage(teacher),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
