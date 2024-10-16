import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // User details
  Map<String, String> userDetails = {
    'name': 'Dr. Blessed Prince P',
    'image': 'assets/blessed sir.webp',
    'availability': 'Monday: 10 to 12\nTuesday: 10 to 12\nWednesday: 12 to 2\nThursday: 9 to 10\nFriday: 10 to 11',
    'cabin': 'LS07',
    'description': 'A highly experienced administrator with a passion for teaching and helping students.'
  };

  // Controllers for editing
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cabinController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isEditing = false; // Track if user is editing

  @override
  void initState() {
    super.initState();
    // Set initial values in controllers
    nameController.text = userDetails['name']!;
    cabinController.text = userDetails['cabin']!;
    availabilityController.text = userDetails['availability']!;
    descriptionController.text = userDetails['description']!;
  }

  // Save updated details
  void saveDetails() {
    setState(() {
      userDetails['name'] = nameController.text;
      userDetails['cabin'] = cabinController.text;
      userDetails['availability'] = availabilityController.text;
      userDetails['description'] = descriptionController.text;
      isEditing = false; // Exit edit mode when saving
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Image
                Column(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(userDetails['image']!),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

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
                ),

                // Description
                buildEditableField(
                  label: 'Description:',
                  controller: descriptionController,
                  isEditing: isEditing,
                ),
              ],
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
