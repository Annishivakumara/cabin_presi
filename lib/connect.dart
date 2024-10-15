
import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final List<Map<String, String>> teachers = [
    {
      'name': 'Dr.Blessed Prince P',
      'image': 'assets/blessed sir.webp',
      'availability': 'Monday: 10 to 12 , Friday: 10 to 11',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 101'
    },
    {
      'name': 'Dr.Pallavi R',
      'image': 'assets/teacher 2.jpg',
      'availability': 'Monday - Wednesday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 102'
    },
    {
      'name': 'Dr.Shanmugharatinam G',
      'image': 'assets/teacher 3.jpg',
      'availability': 'Tuesday - Friday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 103'
    },
    {
      'name': 'Dr.Zafar Ali Khan',
      'image': 'assets/teacher 4.jpg',
      'availability': 'Monday - Thursday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 104'
    },
    {
      'name': 'Madam',
      'image': 'assets/teacher 5.jpg',
      'availability': 'Wednesday - Friday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 105'
    },
    {
      'name': 'Dr.Shanthi Pichandi Anandaraj',
      'image': 'assets/teacher 6.jpg',
      'availability': 'Monday - Friday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 106'
    },
    {
      'name': 'Dr.SenthilKumar S',
      'image': 'assets/teacher 7.jpg',
      'availability': 'Tuesday - Thursday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 107'
    },
    {
      'name': 'Ms.Poornima Selvaraj',
      'image': 'assets/teacher 8.jpg',
      'availability': 'Monday - Friday',
      'timetable': 'assets/timetable.png',
      'cabin': 'Cabin 108'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTeachers = teachers
        .where((teacher) =>
            teacher['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connect',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003F63),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF003F63),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a teacher...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredTeachers.isEmpty
                ? const Center(
                    child: Text(
                      'No Teacher Found',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTeachers.length,
                    itemBuilder: (context, index) {
                      final teacher = filteredTeachers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TeacherDetailPage( teacher),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(teacher['image']!),
                                radius: 30,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teacher['name']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Cabin: ${teacher['cabin']}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
class TeacherDetailPage extends StatefulWidget {
  final Map<String, String> teacher;

  const TeacherDetailPage(this.teacher, {super.key});

  @override
  _TeacherDetailPageState createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  final TextEditingController _purposeController = TextEditingController();
  bool isAppointmentSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    widget.teacher['name']!,
    style: const TextStyle(color: Colors.white), // Set text color to white
  ),
   iconTheme: IconThemeData(color: Colors.white),
  backgroundColor: const Color(0xFF003F63),
),

      backgroundColor: const Color(0xFF003F63),
      body: SingleChildScrollView( // Added Scroll View
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.teacher['image']!),//
                radius: 60,
              ),
              const SizedBox(height: 16),
              Text(
                widget.teacher['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Availability: ${widget.teacher['availability']}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Cabin: ${widget.teacher['cabin']}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
             TextField(
  controller: _purposeController,
  decoration: InputDecoration(
    hintText: 'Enter the purpose of appointment',
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),
  ),
  maxLines: 10, // Set maximum lines to create a larger box
  minLines: 5, // Set minimum lines to start with a larger box
),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isAppointmentSent
                    ? null
                    : () {
                        String purpose = _purposeController.text;
                        if (purpose.isNotEmpty) {
                          setState(() {
                            isAppointmentSent = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Request sent to ${widget.teacher['name']} for "$purpose"'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter the purpose'),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isAppointmentSent ? Colors.greenAccent : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  isAppointmentSent ? 'Appointment Sent' : 'Send Appointment Request',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isAppointmentSent ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}