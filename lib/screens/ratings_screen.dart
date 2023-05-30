import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waru_bora_test/screens/tabs_screen.dart';
import '../models/ratings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  int rating = 0;
  String comment = '';
  final TextEditingController commentController = TextEditingController();

  //final user = FirebaseAuth.instance.currentUser;
  //final email = user?.email ?? '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void saveFeedback() async {
    final feedback = FeedbackData(rating, comment);

    final user = _auth.currentUser;
    final email = user?.email ?? '';

    FirebaseFirestore.instance.collection('ratings').add({
      'email': email,
      'rating': feedback.rating,
      'comment': feedback.comment,
      'timestamp': DateTime.now(),
    }).then((value) {
      print('Feedback saved');
      //saveOrder();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your feedback captured successfully!"),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) => print('Failed to save feedback: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RATE OUR APP'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 1; i <= 5; i++)
              IconButton(
                icon: Transform.scale(
                  scale: 1.5,
                  child: Icon(
                    i <= rating ? Icons.star : Icons.star_border,
                    color: const Color.fromARGB(255, 225, 152, 43),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    rating = i;
                  });
                },
              ),
          ]),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: commentController,
              decoration: const InputDecoration(
                labelText: 'Add a comment ... (optional)',
              ),
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              saveFeedback();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabScreen(),
                ),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      )),
    );
  }
}
