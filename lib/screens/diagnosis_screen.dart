import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

//

import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<void> _predictImage() async {
    final uri = Uri.parse('https://011d-41-89-64-52.ngrok-free.app');
    final request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    try {
      final response = await request.send();
      final responseJson = jsonDecode(await response.stream.bytesToString());
      setState(() {
        _predictionResult = responseJson['prediction'];
      });
      _showResultPopup();
    } catch (e) {
      print(e);
      // Show error message to the user
    }
  }

  //result popup

  void _showResultPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Diagnosis Result'),
            content: Text(_predictionResult ?? ''),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      //body
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          //prediction button
          ElevatedButton(
              onPressed: _imageFile == null ? null : _predictImage,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  backgroundColor: const Color.fromARGB(255, 239, 234, 234)),
              child: const Text('PREDICTION'))
        ],
      )),
    );
  }
}
