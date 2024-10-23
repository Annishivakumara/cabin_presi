import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63), // Background color of the whole page
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('issues').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var issue = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestDetailPage(requestId: issue.id, issueData: issue),
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
                        issue['studentName'], // Display student name
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
          );
        },
      ),
    );
  }
}
class RequestDetailPage extends StatefulWidget {
  final String requestId;
  final QueryDocumentSnapshot issueData;

  const RequestDetailPage({Key? key, required this.requestId, required this.issueData}) : super(key: key);

  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  final TextEditingController responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request #${widget.requestId} Details'),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFF003F63),
      body: SingleChildScrollView(
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
                  children: [
                    const Text(
                      'Student Issue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Black text for title
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.issueData['issue'], // Display issue from Firestore
                      style: const TextStyle(
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
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle response submission
                        FirebaseFirestore.instance.collection('responses').add({
                          'requestId': widget.requestId,
                          'response': responseController.text,
                          'timestamp': FieldValue.serverTimestamp(),
                        }).then((_) {
                          Navigator.pop(context); // Navigate back after submitting
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003F63),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: const Text(
                        'Submit Response',
                        style: TextStyle(fontSize: 16, color: Colors.white),
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