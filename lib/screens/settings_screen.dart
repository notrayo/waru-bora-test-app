import 'package:flutter/material.dart';
import '../data/medicine_data.dart';

import '../data/medicine_firestore.dart';
//import '../models/dawa.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            saveMedicineData(dummyMedicine);
          },
          child: const Text('Save Medicine Data'),
        ),
      ),
    );
  }
}
