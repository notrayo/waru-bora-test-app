import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Text('First Name: $firstName'),
            // Text('Last Name: $lastName'),
            // Text('Email: $email'),
            // Text('Phone Number: $phoneNumber'),
          ],
        ),
      ),
    );
  }
}
