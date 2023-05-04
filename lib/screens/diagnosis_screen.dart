import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

//

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

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
  String? _predictionResult;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Communicating with Flask Backend

  // Future<void> _predictImage() async {
  //   final uri = Uri.parse('https://011d-41-89-64-52.ngrok-free.app');
  //   final request = http.MultipartRequest('POST', uri);
  //   request.files
  //       .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

  //   try {
  //     final response = await request.send();
  //     final responseJson = jsonDecode(await response.stream.bytesToString());
  //     setState(() {
  //       _predictionResult = responseJson['prediction'];
  //     });
  //     _showResultPopup();
  //   } catch (e) {
  //     print(e);
  //     // Show error message to the user
  //   }
  // }

  //result popup

  // void _showResultPopup() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Diagnosis Result'),
  //           content: Text(_predictionResult ?? ''),
  //           actions: [
  //             ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'))
  //           ],
  //         );
  //       });
  // }

  // Taking user to Flask app functionality

  final Uri _url = Uri.parse('https://961e-41-90-177-61.ngrok-free.app');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
                  '2. Upload taken photo to the server',
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
                onPressed: (() {}),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent),
                child: const Text('UPLOAD TO SERVER')),
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
                  '3. Visit Server for Disease Prediction',
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
            ElevatedButton(
                onPressed: _launchUrl,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    backgroundColor: const Color.fromARGB(255, 239, 234, 234)),
                child: const Text('VISIT SERVER 2 PREDICT')),
          ],
        ),
      ),
    );
  }
}
