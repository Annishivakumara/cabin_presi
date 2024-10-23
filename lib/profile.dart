import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User details
  String userId = 'unique_user_id'; // Replace with actual user ID from authentication
  String? profileImage;
  String name = '';
  String cabin = '';
  String availability = '';
  String description = '';
  bool isEditing = false; // Track if user is editing

  // Controllers for editing
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cabinController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      setState(() {
        profileImage = userDoc['image'];
        name = userDoc['name'];
        cabin = userDoc['cabin'];
        availability = userDoc['availability'];
        description = userDoc['description'];
      });
      // Set initial values in controllers
      nameController.text = name;
      cabinController.text = cabin;
      availabilityController.text = availability;
      descriptionController.text = description;
    }
  }

  // Pick an image from the gallery
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = image.path; // Update profile image path
      });
    }
  }

  // Save updated details to Firestore
  void saveDetails() {
    setState(() {
      name = nameController.text;
      cabin = cabinController.text;
      availability = availabilityController.text;
      description = descriptionController.text;
      isEditing = false; // Exit edit mode when saving
    });

    // Save to Firestore
    _firestore.collection('users').doc(userId).set({
      'image': profileImage,
      'name': name,
      'cabin': cabin,
      'availability': availability,
      'description': description,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003F63), // Set background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF003F63),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            color: Colors.white,
            onPressed: () {
              if (isEditing) {
                saveDetails();
              } else {
                setState(() {
                  isEditing = true; // Enter edit mode
                });
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchUserData, // Pull-to-refresh feature
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensure scrollability for refresh
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: isEditing ? pickImage : null, // Only pick image when in edit mode
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: profileImage != null
                              ? FileImage(File(profileImage!))
                              : const AssetImage('assets/user (2).png') as ImageProvider, // Default image
                        ),
                      ),
                      // Edit icon (shown when editing)
                      if (isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.white), // Black camera icon
                            onPressed: pickImage,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name (Editable when in edit mode)
                  buildEditableField(
                    label: 'Name:',
                    controller: nameController,
                    isEditing: isEditing,
                  ),

                  // Cabin
                  buildEditableField(
                    label: 'Cabin:',
                    controller: cabinController,
                    isEditing: isEditing,
                  ),

                  // Availability (centered text)
                  buildEditableField(
                    label: 'Availability:',
                    controller: availabilityController,
                    isEditing: isEditing,
                    isCentered: true,
                    maxLines: 3,
                  ),

                  // Description
                  buildEditableField(
                    label: 'Description:',
                    controller: descriptionController,
                    isEditing: isEditing,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for editable fields
  Widget buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    bool isCentered = false,
    int maxLines = 1,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: isEditing
            ? Border.all(color: Colors.blue, width: 2) // Highlight when editing
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(height: 10),
          isEditing
              ? TextField(
                  controller: controller,
                  maxLines: maxLines,
                  textAlign: isCentered ? TextAlign.center : TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                )
              : Text(
                  controller.text,
                  textAlign: isCentered ? TextAlign.center : TextAlign.left,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: ProfilePage()));
}
