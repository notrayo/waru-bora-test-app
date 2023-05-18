import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

//

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import 'package:mime_type/mime_type.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

// popup logic will go here ...

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  //image file

  File? _imageFile;

  //new string file
  // String? _predictionResult;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Communicating with Flask Backend

  // Taking user to Flask app functionality

  final Uri _url = Uri.parse('https://087c-41-90-179-242.ngrok-free.app/');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Uploading Image file to Flask Server

  String? message = "";

  uploadImage() async {
    if (_imageFile == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No image selected'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');

      final firebase_storage.UploadTask uploadTask = ref.putFile(_imageFile!);
      final firebase_storage.TaskSnapshot snapshot =
          await uploadTask.whenComplete(() {});
      final String imageUrl = await snapshot.ref.getDownloadURL();

      // Send the imageUrl to the admin app using FCM
      // ...

      // Show success dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Image uploaded successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error uploading image: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      //body
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Disclaimer: ',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 69, 69, 69),
              ),
            ),
            ListTileTheme(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.warning_amber),
                      title: Text(
                          'Due to dependency limitations, please upload one image at a time. If multiple images, use gmail'),
                    ),
                    ListTile(
                      leading: Icon(Icons.warning_amber),
                      title: Text('Company email : rayoleeroy@gmail.com'),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  '1. Take photo of your sick potato leaf',
                  style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 46, 45, 45)),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 300,
                    width: 300,
                  )
                : const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('No image selected'),
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent),
                  child: const Text('Take photo...'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text('Select from gallery'),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  '2. Upload taken photo to Agrovet Admin',
                  style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 67, 60, 60)),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //prediction button
            ElevatedButton(
                onPressed:
                    //uploadImage,
                    uploadImage,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 64, 204, 26)),
                child: const Text('UPLOAD IMAGE ')),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  '3. Wait for feedback from Agrovet ',
                  style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 67, 60, 60)),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
