import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _bodyController = TextEditingController();

  List<String> _attachmentPaths = [];

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
        final String recipientEmail = 'mbururyan31@gmail.com';
        final String emailSubject = 'Test Email';
        final String emailBody =
            'Sender Email: $senderEmail\n\n${_bodyController.text}';

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
      appBar: AppBar(
        title: const Text('CHAT / Email test SCREEN'),
      ),
      body: Padding(
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
      ),
    );
  }
}
