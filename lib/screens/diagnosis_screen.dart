import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  File? _imageFile;
  //File? _attachedImageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

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
      final User? user = FirebaseAuth.instance.currentUser;
      final String userEmail = user!.email!;
      final DateTime now = DateTime.now();

      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');

      final firebase_storage.UploadTask uploadTask = ref.putFile(_imageFile!);
      final firebase_storage.TaskSnapshot snapshot =
          await uploadTask.whenComplete(() {});
      final String imageUrl = await snapshot.ref.getDownloadURL();

      // Send the image to firestore database

      await FirebaseFirestore.instance.collection('images').add({
        'email': userEmail,
        'imageUrl': imageUrl,
        'timestamp': now,
      });
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

  //email functionality

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _bodyController = TextEditingController();

  final List<String> _attachmentPaths = [];

  Future<void> _attachImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _attachmentPaths.add(pickedImage.path);
      });
    }
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        final String senderEmail = user.email!;
        const String recipientEmail = 'mbururyan31@gmail.com';
        const String emailSubject = 'Waru Bora Farmer Diagnosis Request';
        final String emailBody =
            'Farmer app authenticated Email: $senderEmail\n\n${_bodyController.text}';

        final Email email = Email(
          body: emailBody,
          subject: emailSubject,
          recipients: [recipientEmail],
          cc: [],
          bcc: [],
          attachmentPaths: _attachmentPaths,
          isHTML: false,
        );

        try {
          await FlutterEmailSender.send(email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email sent successfully')),
          );
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send email')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('User not logged in or no email address')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _bodyController.dispose();
    super.dispose();
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
                      title: Text('Company email : mbururyan31@gmail.com'),
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
                  '1. Take / View photo of sick potato leaf',
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
                  '2. Upload photo to Database',
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
            Row(
              children: const [
                Text(
                  '3. Contact Agrovet Specialist ',
                  style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 67, 60, 60)),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _bodyController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Email Body',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the email body';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _attachImage,
                      child: const Text('Attach Image'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _sendEmail,
                      child: const Text('Send Email'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
