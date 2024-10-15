import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63), // Background color for the scaffold
      appBar: AppBar(
        backgroundColor: const Color(0xFF003F63),
        title: const Text(
          'PU CLUBS',
          style: TextStyle(
            color: Colors.white, // White text for the AppBar
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set color of icons, including the back arrow
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 containers per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: List.generate(10, (index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the ClubDetailPage with corresponding club details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClubDetailPage(
                      name: names[index],
                      image: images[index],
                      description: descriptions[index],
                      url: urls[index], // Pass the URL to the detail page
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          images[index], // Load the corresponding image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        names[index], // Display the corresponding name
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Change this to white if you want
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Details Page for the Clubs
class ClubDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String url; // Add URL parameter

  const ClubDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.url, // Initialize the URL
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Color(0xFF003366)),
 // Make text white
        ),
        elevation: 10,
        iconTheme: const IconThemeData(
  color: Color(0xFF003366), // Set color of icons to dark blue
),

        backgroundColor: const Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFF003F63),
      body: Padding(
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
                color: Colors.white, // Set text color to white
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.white), // Set description text color to white
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Open WebView with the specified URL
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(url: url),
                    ),
                  );
                },
                child: const Text('Open Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WebView Page to display the URL
class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          'PU join',
          style: TextStyle(
            color: const Color(0xFF003F63), // White text for the AppBar
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF003366), // Set color of icons, including the back arrow
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted, // Allow JavaScript
      ),
    );
  }
}

// List of images, names, descriptions, and URLs
final List<String> images = [
  'assets/omega.jpeg',//1
  'assets/rotrct.png',//2
  'assets/singing.jpeg',//3
  'assets/DANCING.webp',//4
  'assets/build.jpeg',//5
  'assets/pus.jpg',//6
  'assets/pus.jpg',//7
  'assets/pus.jpg',//8
  'assets/pus.jpg',//9
  'assets/pus.jpg',//10
];

final List<String> names = [
  'OMEGA CLUB',
  'ROTRACT ',
  'GAMING ',
  'MUSIC CLUB',
  'CODING CLUB',
  'MUSIC CLUB',
  'CRICKET',
  'COLORING',
  'START UP ',
  'TEACHING CLUB',
];

// Add descriptions for each club
final List<String> descriptions = [
  'The Omega Club focuses on leadership and community service, bringing together individuals with a passion for making a difference...',
  'Rotaract Club aims to promote social activities and networking opportunities for young professionals and students...',
  'Gaming Club is a haven for game enthusiasts and e-sports players who want to dive deep into the world of gaming...',
  'Music Club allows members to explore and create music in a collaborative and supportive environment...',
  'Coding Club is for those passionate about coding and software development...',
  'Cricket Club brings together players for practice and tournaments...',
  'Coloring Club is for anyone who enjoys coloring as a form of relaxation and creativity...',
  'Startup Club is designed for aspiring entrepreneurs and innovators...',
  'Teaching Club is focused on fostering a love for education...',
  'Additional description for club 10...',
];

// URLs for each club
final List<String> urls = [
  'https://chatgpt.com/c/670d5c8d-ac9c-8008-ae50-1541cd069777',
  'https://example.com/rotaract-club',
  'https://example.com/gaming-club',
  'https://example.com/music-club',
  'https://example.com/coding-club',
  'https://example.com/cricket-club',
  'https://example.com/coloring-club',
  'https://example.com/startup-club',
  'https://example.com/teaching-club',
  'https://example.com/club10',
];
