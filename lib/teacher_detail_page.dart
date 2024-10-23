import 'package:flutter/material.dart';

class TeacherDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String availability;
  final String cabin;
  final String description;

  const TeacherDetailPage({
    required this.name,
    required this.image,
    required this.availability,
    required this.cabin,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003366),
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Color(0xFF003366)),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 10,
        iconTheme: const IconThemeData(color: Color(0xFF003366)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teacher Image
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 70.0,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Name Section
            _buildInfoSection('Name', name),
            // Cabin Section
            _buildInfoSection('Cabin', cabin),
            // Availability Section
            _buildInfoSection('Availability', availability),
            // Description Section
            _buildInfoSection('Description', description),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF003366),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: const Color(0xFF0076CE),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
