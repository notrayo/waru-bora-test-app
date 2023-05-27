//import 'package:flutter/material.dart';

//import './medicine_data.dart';
import '../models/dawa.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void saveMedicineData(List<Dawa> medicines) {
  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('medicine');

  for (var medicine in medicines) {
    medicineCollection
        .doc()
        .set({
          'id': medicine.id,
          'category': medicine.category,
          'title': medicine.title,
          'type': medicine.type.toString().split('.').last,
          'imageLink': medicine.imageLink,
          'benefits': medicine.benefits,
          'howToUse': medicine.howToUse,
          'price': medicine.price,
          'agroNumber': medicine.agroPhoneNumber,
        })
        .then((value) => print('Medicine data saved successfully!'))
        .catchError((error) => print('Failed to save medicine data: $error'));
  }
}
