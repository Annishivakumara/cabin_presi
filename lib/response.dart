import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63), // Background color of the whole page
      body: ListView.builder(
        itemCount: 5, // Example count of student requests
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestDetailPage(requestId: index),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, // Container background color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Student Request ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Click to view more details.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black, // Black text for description
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RequestDetailPage extends StatelessWidget {
  final int requestId;

  const RequestDetailPage({Key? key, required this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController responseController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Request #$requestId Details'),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFF003F63),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Container background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Student Issue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Black text for title
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "_I'm unable to register for the Data Structures course, which is a required subject for my degree. Despite having completed all the prerequisites last semester, the registration portal shows that I’m not eligible. I’ve double-checked my course history, and it seems to be a system error. This course is crucial for my next semester’s schedule, and without it, I might fall behind in my academic plan.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Black text for content
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Container background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Response',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Black text for response title
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: responseController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Enter your response here...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white, // Response input background
                      ),
                      style: const TextStyle(color: Colors.black), // Black text in input
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add your submit logic here
                    Navigator.pop(context); // Go back after submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Submit button color
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Color(0xFF003F63), // Text color for button
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
