import 'package:flutter/material.dart';

class FavsScreen extends StatelessWidget {
  const FavsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: const Center(
        child: Text('Favourite medicines will go here ...'),
      ),
    );
  }
}
