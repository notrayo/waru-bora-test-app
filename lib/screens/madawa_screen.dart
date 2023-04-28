// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
// import '../models/dawa.dart';
//import '../data/medicine_data.dart';

//importing data file

import '../data/medicine_data.dart';
import '../widgets/dawa_items.dart';

class DawaScreen extends StatelessWidget {
  //const DawaScreen({super.key});

  final String categoryID;
  final String categoryTitle;

  const DawaScreen(this.categoryID, this.categoryTitle, {super.key});

  @override

  //

  Widget build(BuildContext context) {
    final categoryMedicine = dummyMedicine.where((Dawa) {
      return Dawa.category.contains(categoryID);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemCount: categoryMedicine.length,
          itemBuilder: (context, index) {
            //testing
            return DawaItem(
              id: categoryMedicine[index].id,
              category: categoryMedicine[index].category,
              title: categoryMedicine[index].title,
              type: categoryMedicine[index].type,
              imageLink: categoryMedicine[index].imageLink,
              price: categoryMedicine[index].price,
            );
          },
        ));
  }
}
