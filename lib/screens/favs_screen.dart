import 'package:flutter/material.dart';
import '../models/dawa.dart';

class FavsScreen extends StatelessWidget {
  const FavsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAVOURITES'),
      ),
    );
  }
}
