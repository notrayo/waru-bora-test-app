//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/disease_category.dart';
import '../models/dawa.dart';

const dummyCategories = [
  DiseaseCategory(
    id: 'c1',
    title: 'Early Blight',
    color: Color.fromARGB(255, 53, 6, 239),
  ),
  DiseaseCategory(
    id: 'c2',
    title: 'Late Blight',
    color: Color.fromARGB(255, 180, 81, 45),
  ),
  DiseaseCategory(
    id: 'c3',
    title: 'Healthy Plant',
    color: Color.fromARGB(255, 81, 153, 118),
  )
];

// data on the medicine

const dummyMedicine = [
  Dawa(
    id: 'i1',
    category: ['c1'],
    title: 'Liquid Copper Fungiside',
    type: DawaType.fungiside,
    imageLink: 'assets/liquid copper fungicide.jpg',
    benefits: [
      'controls potential diseases',
      'controls potential fungi : moss and algae'
    ],
    howToUse: [
      'two caps of liquid to be mixed with water',
      'use hose end sprayer to spray on leaves'
    ],
    price: 3000,
    agroPhoneNumber: 072093735,
  )
];
