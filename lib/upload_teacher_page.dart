import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart'; // For handling CSV parsing

class UploadTeacherPage extends StatefulWidget {
  const UploadTeacherPage({Key? key}) : super(key: key);

  @override
  _UploadTeacherPageState createState() => _UploadTeacherPageState();
}

class _UploadTeacherPageState extends State<UploadTeacherPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _cabinController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _uploadTeacherDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('teachers').add({
          'name': _nameController.text.trim(),
          'image': _imageController.text.trim(),
          'availability': _availabilityController.text.trim(),
          'cabin': _cabinController.text.trim(),
          'description': _descriptionController.text.trim(),
        });

        // Clear the text fields
        _nameController.clear();
        _imageController.clear();
        _availabilityController.clear();
        _cabinController.clear();
        _descriptionController.clear();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Teacher details uploaded successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload teacher details: $e')),
        );
      }
    }
  }

Future<void> _uploadCSVFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      // Safely check if fileBytes is null
      final fileBytes = result.files.single.bytes;
      
      if (fileBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to read CSV file data.')),
        );
        return;
      }

      final csvString = String.fromCharCodes(fileBytes);
      List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

      int successfulUploads = 0;
      int failedUploads = 0;

      for (var row in csvData) {
        if (row.length >= 5) {
          try {
            await FirebaseFirestore.instance.collection('teachers').add({
              'name': row[0].toString(),
              'image': row[1].toString(),
              'availability': row[2].toString(),
              'cabin': row[3].toString(),
              'description': row[4].toString(),
            });
            successfulUploads++;
          } catch (e) {
            failedUploads++;
            print('Error uploading row: $row, Error: $e');
          }
        } else {
          failedUploads++;
          print('Invalid row data: $row');
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV upload complete: $successfulUploads successful, $failedUploads failed.'),
        ),
      );
    } else {
      // Handle file picking failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick or read CSV file.')),
      );
    }
  } catch (e) {
    print('Error while uploading CSV file: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Teacher Details', style: TextStyle(color: Color(0xFF003F63))),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF003F63),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the image URL';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _availabilityController,
                    decoration: const InputDecoration(labelText: 'Availability'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter availability details';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cabinController,
                    decoration: const InputDecoration(labelText: 'Cabin'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the cabin number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _uploadTeacherDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003F63),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Upload'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _uploadCSVFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003F63),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Upload CSV File'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
