import 'package:flutter/material.dart';
import 'career page.dart';
import 'career_support.dart'; // Importing the new Career Support page
import 'about_page.dart';
import 'teacher_detail_page.dart';
import 'group.dart';
import 'profile.dart'; 
import 'mail.dart';// Importing the Profile page

class HomePage extends StatefulWidget {
  final bool isAdmin; // Accepting the isAdmin parameter

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

    // Define the pages for regular users
    _pages = [
       TeachersPage(),
      const CareerPage(),
      const CareerSupportPage(), // New Career Support Page
      const GroupPage(),
    ];

    // If the user is an admin, add the ProfilePage
    if (widget.isAdmin) {
      _pages.add(ProfilePage()); // Admin Profile Page
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63),
     appBar: AppBar(
  backgroundColor: const Color(0xFFFFFFFF),
  title: const Align(
    alignment: Alignment.centerLeft, // Start title from the left
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
   IconButton(
            icon: const Icon(Icons.mail_outline, color: Color(0xFF003F63)), // Mailbox icon
            onPressed: _goToMailPage, // Navigate to the MailPage
          ),
    IconButton(
      icon: const Icon(Icons.info_outline, color: Color(0xFF003F63)), // Info icon
      onPressed: _goToAboutPage, // Navigate to the AboutPage
    ),
  ],
),

      body: _pages[_currentIndex], // Dynamically show the correct page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF003F63),
        unselectedItemColor: const Color(0xFF000000),
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
          const BottomNavigationBarItem(
            icon: Icon(Icons.handshake),

            label: 'Mentor', // New Career Support Page
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubs',
          ),
          if (widget.isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile', // Only for admin users
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
  final List<Map<String, String>> _teachers = [
    {
      'name': 'Dr.Blessed Prince P',
      'image': 'assets/blessed sir.webp',
      'availability': 'Monday: 10 to 12 , Friday: 10 to 11',
    
      'cabin': 'Cabin 101'
    },
    {
      'name': 'Dr.Pallavi R',
      'image': 'assets/teacher 2.jpg',
      'availability': 'Monday - Wednesday',
    
      'cabin': 'Cabin 102'
    },
    {
      'name': 'Dr.SenthilKumar S',
      'image': 'assets/teacher 7.jpg',
      'availability': 'Tuesday - Thursday',
      
      'cabin': 'Cabin 107'
    },
    
    {
      'name': 'Dr.Zafar Ali Khan',
      'image': 'assets/teacher 4.jpg',
      'availability': 'Monday - Thursday',
      
      'cabin': 'Cabin 104'
    },
    {
      'name': 'Madam',
      'image': 'assets/teacher 5.jpg',
      'availability': 'Wednesday - Friday',
      
      'cabin': 'Cabin 105'
    },
    {
      'name': 'Dr.Shanthi Pichandi Anandaraj',
      'image': 'assets/teacher 6.jpg',
      'availability': 'Monday - Friday',
     
      'cabin': 'Cabin 106'
    },
    {
      'name': 'Dr.Shanmugharatinam G',
      'image': 'assets/teacher 3.jpg',
      'availability': 'Tuesday - Friday',
      
      'cabin': 'Cabin 103'
    },
    
    {
      'name': 'Ms.Poornima Selvaraj',
      'image': 'assets/teacher 8.jpg',
      'availability': 'Monday - Friday',
      
      'cabin': 'Cabin 108'
    },
  ];

  List<Map<String, String>> _filteredTeachers = [];

  @override
  void initState() {
    super.initState();
    _filteredTeachers = _teachers;
  }

  void _filterTeachers(String query) {
    setState(() {
      _filteredTeachers = _teachers
          .where((teacher) => teacher['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetailPage(Map<String, String> teacher) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherDetailPage(
          name: teacher['name']!,
          image: teacher['image']!,
          availability: teacher['availability']!,
          cabin: teacher['cabin']!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63), // Background color
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Teachers' List
            Expanded(
              child: _filteredTeachers.isEmpty
                  ? const Center(
                      child: Text(
                        'No teacher found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFE64833), // Text color if no teachers found
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
                                  offset: const Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(teacher['image']!),
                                radius: 30.0,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    teacher['name']!,
                                    style: const TextStyle(
                                      color: Color(0xFF003F63), // Darker blue text color
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14, // Reduced font size
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    teacher['cabin']!, // Cabin number
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12, // Reduced font size
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF003F63), // Arrow icon color
                                size: 18, // Icon size
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
    );
  }
}
