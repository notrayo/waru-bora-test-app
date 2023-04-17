import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

import '../models/disease_category.dart';
import '../data/categories_data.dart';

class CategoryItem extends StatelessWidget {
  final DiseaseCategory category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.7),
                category.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Please pick the diagnosis you got of the potato plant so as to view viable medication:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dummyCategories.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15),
                child: CategoryItem(category: dummyCategories[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
