import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

// popup logic will go here ...

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  //image file

  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
              onPressed: (() {}),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  backgroundColor: const Color.fromARGB(255, 239, 234, 234)),
              child: const Text('PREDICTION'))
        ],
      )),
    );
  }
}
