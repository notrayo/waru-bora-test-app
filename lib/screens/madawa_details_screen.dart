import 'package:flutter/material.dart';

class DawaDetailsScreen extends StatelessWidget {
  static const routeName = '/dawa-detail';

  const DawaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dawaID = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(dawaID),
      ),
      body: Text('medicine details of $dawaID'),
    );
  }
}
