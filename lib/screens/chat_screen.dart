import 'package:flutter/material.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import './location_maps_screen.dart';

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

  final List<String> _attachmentPaths = [];

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        final String senderEmail = user.email!;
        const String recipientEmail = 'mbururyan31@gmail.com';
        const String emailSubject = 'Non-diagnosis Farmer Email';
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
        title: const Text('Contact Us '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Email Us: ',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 69, 69, 69),
              ),
            ),
            const SizedBox(
              height: 30,
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
                    // ElevatedButton(
                    //   onPressed: _attachImage,
                    //   child: const Text('Attach Image'),
                    // ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _sendEmail,
                      child: const Text('Send Email'),
                    ),
                  ],
                ),
              ),
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
            const Text(
              'Call Us: ',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 69, 69, 69),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                // const phoneNumber = '0791 266 895';
                // final cleanedPhoneNumber = phoneNumber.replaceAll(' ', '');

                // final Uri url = Uri(scheme: 'tel', path: cleanedPhoneNumber);

                // if (await canLaunchUrl(url)) {
                //   await launchUrl(url);
                // } else {
                //   throw 'cannot launch phone dialer';
                // }

                const phoneNumber = '0791266895';
                const url = 'tel:$phoneNumber';

                launch(url);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const MapsScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 56, 143, 2),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '0791 266 895',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(
                      Icons.call,
                      size: 35,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Locate Us : ',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 69, 69),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapsScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Google',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Maps',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(
                      Icons.location_on_sharp,
                      size: 35,
                      color: Colors.green,
                    )
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
