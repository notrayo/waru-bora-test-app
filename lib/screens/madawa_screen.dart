import 'package:flutter/material.dart';

class DawaScreen extends StatelessWidget {
  //const DawaScreen({super.key});

  final String categoryID;
  final String categoryTitle;

  DawaScreen(this.categoryID, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('medication for $categoryTitle with ID: $categoryID'),
      ),
    );
  }
}
