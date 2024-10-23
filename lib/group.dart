import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GroupPage(),
    );
  }
}

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  Future<bool> _isAdmin(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists && doc.data()?['isAdmin'] == true; // Check if user is admin
  }

  @override
  Widget build(BuildContext context) {
    String userId = "current_user_id"; // Replace with your user ID fetching logic

    return Scaffold(
      backgroundColor: const Color(0xFF003F63),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003F63),
        title: const Text(
          'PU CLUBS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          FutureBuilder<bool>(
            future: _isAdmin(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError || !snapshot.data!) {
                return Container(); // Not an admin or error, return empty container
              }
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UploadClubPage()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final clubs = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClubDetailPage(
                          name: club['name'],
                          image: club['image'],
                          description: club['description'],
                          url: club['url'],
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
                            child: Image.network(
                              club['image'],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.black,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            club['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
      ),
    );
  }
}

// Details Page for the Clubs
class ClubDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String url;

  const ClubDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Color(0xFF003366)),
        ),
        elevation: 10,
        iconTheme: const IconThemeData(
          color: Color(0xFF003366),
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
                child: Image.network(image, height: 200, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
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

// Upload Club Page for Admin
class UploadClubPage extends StatelessWidget {
  const UploadClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final imageController = TextEditingController();
    final descriptionController = TextEditingController();
    final urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Club'),
        backgroundColor: const Color(0xFF003F63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Club Name'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'Club URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final clubData = {
                  'name': nameController.text,
                  'image': imageController.text,
                  'description': descriptionController.text,
                  'url': urlController.text,
                };

                await FirebaseFirestore.instance.collection('clubs').add(clubData);
                Navigator.pop(context); // Go back to GroupPage after uploading
              },
              child: const Text('Upload Club'),
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
          'PU Join',
          style: TextStyle(
            color: Color(0xFF003F63),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF003366),
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
