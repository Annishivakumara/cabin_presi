import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

class ClubDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String formUrl;

  const ClubDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.formUrl,
  }) : super(key: key);

  Future<void> _launchURL() async {
    if (await canLaunch(formUrl)) {
      await launch(formUrl);
    } else {
      throw 'Could not launch $formUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Color(0xFF003366)), // Set text color to white
        ),
        backgroundColor: const Color(0xFFFFFFFF), // Darker shade of blue
        iconTheme: const IconThemeData(color: Colors.white), // Set back arrow color to white
      ),
      body: Container(
        color: const Color(0xFF003F63),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(image, height: 200, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            // Add the button to launch the URL
            ElevatedButton(
  onPressed: _launchURL,
  child: const Text(
    'Join Club',
    style: TextStyle(color: Colors.white), // Set text color to white for better visibility
  ),
  style: ElevatedButton.styleFrom(
   backgroundColor: const Color(0xFF007BFF), // Set the button background color to a lighter blue or any contrasting color
    // Optionally, set the overlay color to a different shade for visual feedback on press
   disabledBackgroundColor: Colors.white, // Set the button text color
  ),
),

          ],
        ),
      ),
    );
  }
}
