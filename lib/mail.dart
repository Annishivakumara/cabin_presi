import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MailPage extends StatelessWidget {
  const MailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Requests',
          style: TextStyle(color: Color(0xFF003F63)),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('responses')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var response = snapshot.data!.docs[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to ResponseDetailPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponseDetailPage(
                          requestId: response['requestId'],
                          fullResponse: response['response'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Response to Request #${response['requestId']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hey, here is your response',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ResponseDetailPage extends StatefulWidget {
  final String requestId;
  final String fullResponse;

  const ResponseDetailPage({
    Key? key,
    required this.requestId,
    required this.fullResponse,
  }) : super(key: key);

  @override
  _ResponseDetailPageState createState() => _ResponseDetailPageState();
}

class _ResponseDetailPageState extends State<ResponseDetailPage> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Response Details',
          style: TextStyle(color: Color(0xFF003F63)),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF003366), // Set color of icons
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003F63), Color(0xFF005A8A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Response to Request #${widget.requestId}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.fullResponse,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Rate this response:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 32),
           ElevatedButton(
              onPressed: () {
                // Show a popup dialog thanking the user for their rating
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thank You!'),
                      content: const Text('Thank you for rating us! Your feedback is valuable.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );

                // Optional: Add code here to handle rating submission (e.g., save to Firestore)
              },
              child: const Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }
}

