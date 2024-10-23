import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CareerSupportPage extends StatefulWidget {
  const CareerSupportPage({Key? key}) : super(key: key);

  @override
  _CareerSupportPageState createState() => _CareerSupportPageState();
}

class _CareerSupportPageState extends State<CareerSupportPage> {
  final TextEditingController _issueController = TextEditingController();
  bool _isIssueSent = false;

  // Submitting issue to Firestore
  void _submitIssue() async {
    if (_issueController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('issues').add({
        'issue': _issueController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'studentName': 'Blessed Prince P', // Replace with dynamic student name
      });

      setState(() {
        _isIssueSent = true; // Change to issue sent state
        _issueController.clear(); // Clear the text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mentor Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 30, // Profile image size
                    backgroundImage: AssetImage('assets/blessed sir.webp'), // Replace with your image path
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Blessed Prince P ', // Replace with dynamic student name
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Career Support Services Description
              const Text(
                'Student Support ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We provide a supportive space for students to address personal, college-related, or attendance issues. Our mentor is here to listen and guide you through challenges in your academic journey. Whether you need advice or assistance, don’t hesitate to reach out. Your well-being is our priority.",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 16),
              
              const SizedBox(height: 24),

              // Personal Issue Input Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Raise Your Issue:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003F63),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _issueController,
                      maxLines: 4, // Allow multiple lines
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your issue here...',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitIssue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003F63),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _isIssueSent ? 'Submitted' : 'Submit',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
