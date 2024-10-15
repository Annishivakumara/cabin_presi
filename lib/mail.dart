import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MailPage(),
  ));
}

class MailPage extends StatelessWidget {
  const MailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Requests',
          style: TextStyle(
            color: const Color(0xFF003F63),
 // White text for the AppBar
          ),
        ),
        iconTheme: const IconThemeData(
  color: Color(0xFF003366), // Set color of icons, including the back arrow
),

        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003F63), Color(0xFF005A8A)], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTeacherCard(
              context,
              teacherName: 'Mr. Smith',
              time: '2024-10-15 10:30 AM',
              response: "Thank You for Your RatingWe appreciate your feedback Your rating helps us improve our services and provide a better experience for everyone. ",
            ),
            _buildTeacherCard(
              context,
              teacherName: 'Ms. Johnson',
              time: '2024-10-15 11:00 AM',
              response: 'Thank you for your request. We are processing it and will get back to you soon.',
            ),
            // Add more teacher cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherCard(BuildContext context,
      {required String teacherName, required String time, required String response}) {
    return Card(
      color: Colors.white, // White background for the teacher card
      elevation: 8, // Increased shadow effect for better UI
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Navigate to the details page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestDetailPage(
                teacherName: teacherName,
                time: time,
                response: response,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      teacherName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                response,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestDetailPage extends StatefulWidget {
  final String teacherName;
  final String time;
  final String response;

  const RequestDetailPage({
    Key? key,
    required this.teacherName,
    required this.time,
    required this.response,
  }) : super(key: key);

  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  int _rating = 0; // Track the star rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.teacherName,
          style: const TextStyle(color: Color(0xFF003366)),
// Title text color
        ),
        backgroundColor: const Color(0xFFFFFFFF), // Background color of the AppBar
        iconTheme: const IconThemeData(
           color: Color(0xFF003366), // Set color of the back arrow to white
        ),
      ),
      backgroundColor: const Color(0xFF003F63),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003F63), Color(0xFF005A8A)], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // White background for the response container
                  borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Optional: shadow effect
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Changes the position of the shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request Time: ${widget.time}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.response,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Rate this teacher:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Ensure text is black
                    ),
                    const SizedBox(height: 8),
                    _buildStarRating(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min, // Makes the row take only the needed space
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border, // Filled or empty star icon
            color: Colors.amber, // Star color
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1; // Set rating based on tapped star
            });
            _showThankYouDialog(); // Show thank you dialog after rating
          },
        );
      }),
    );
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text(
            'Thank You!',
            style: TextStyle(color: Color(0xFF003F63)), // Title color
          ),
          content: const Text(
            'Thank you for your rating! Your feedback is important to us.',
            style: TextStyle(color: Colors.black), // Content color
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xFF003F63)), // Button color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
