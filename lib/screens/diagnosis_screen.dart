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

  void _saveImageToGallery() async {
    try {
      final result = await ImageGallerySaver.saveFile(_imageFile!.path);
      if (result['isSuccess']) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Image saved to gallery!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to save image to gallery!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error saving image to gallery: $e'),
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

  // Communicating with Flask Backend

  // Taking user to Flask app functionality

  final Uri _url = Uri.parse('https://961e-41-90-177-61.ngrok-free.app');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Uploading Image file to Flask Server

  String? message = "";

  uploadImage() async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('https://961e-41-90-177-61.ngrok-free.app/'));

    final headers = {'Content-type': 'multipart/form-data'};

    request.files.add(http.MultipartFile(
        'image', _imageFile!.readAsBytes().asStream(), _imageFile!.lengthSync(),
        filename: _imageFile!.path.split('/').last));

    request.headers.addAll(headers);
    request.send();

    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    setState(() {});
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
                          'Due to dependancy issues, youll have to visit our website to interact with our AI model'),
                    ),
                    ListTile(
                      leading: Icon(Icons.warning_amber),
                      title: Text(
                          'The prediction, despite having a 96% accuracy, is based on a machine learning algorithm and is not 100% accurate. Please consult Organix Limited for proper treatment.'),
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
                  '2. Upload taken photo to gallery',
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
                    _saveImageToGallery,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 64, 204, 26)),
                child: const Text('UPLOAD IMAGE TO GALLERY')),
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
