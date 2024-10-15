import 'package:flutter/material.dart';

class TeacherDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String availability;
  final String cabin;

  const TeacherDetailPage({
    required this.name,
    required this.image,
    required this.availability,
    required this.cabin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Split the availability string into a list by commas
    List<String> availabilityList = availability.split(',');

    return Scaffold(
      backgroundColor: const Color(0xFF003366), // Royal blue background
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Color(0xFF003366)),
 // Set text color to white
        ),
        backgroundColor: const Color(0xFFFFFFFF),
 // Darker royal blue
        elevation: 10,
        iconTheme: const IconThemeData(color: Color(0xFF003366)), // Set back arrow color to white
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teacher Image
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 70.0,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            // Name Section
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF003366), // Dark royal blue for heading
                    ),
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF0076CE), // Lighter blue for actual value
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Cabin Section (unchanged)
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Text(
                    'Cabin: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF003366), // Dark royal blue for heading
                    ),
                  ),
                  Expanded(
                    child: Text(
                      cabin,
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF0076CE), // Lighter blue for actual value
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Availability Section (centered with increased width)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width * 0.9, // 90% width of the screen
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Availability: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF003366), // Dark royal blue for heading
                      ),
                    ),
                    const SizedBox(height: 8), // Add space between heading and content

                    // Loop through the availabilityList and display each item in a row
                    ...availabilityList.map((availabilityItem) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Center(
                          child: Text(
                            availabilityItem.trim(), // Trim leading and trailing spaces
                            style: TextStyle(
                              fontSize: 18,
                              color: const Color(0xFF0076CE), // Lighter blue for actual value
                            ),
                            textAlign: TextAlign.center, // Center the text
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
