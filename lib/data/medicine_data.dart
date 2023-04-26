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
  ),
  Dawa(
    id: 'i3',
    category: ['c1', 'c2'],
    title: 'Achook Insectside',
    type: DawaType.insecticide,
    imageLink: 'assets/Achook-100ml-square.png',
    benefits: [
      'controls parasitic nematodes',
      'biogradable'
          'low toxicity'
    ],
    howToUse: [
      'apply 300ml of achook into 60L of water',
      'spray daily in 8 hours intervals'
    ],
    price: 500,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i2',
    category: ['c3'],
    title: 'Nutrivant (Copia Baraka)',
    type: DawaType.fertelizer,
    imageLink: 'assets/nutrivant (Copia Baraka) Fertelizer.jpg',
    benefits: ['increased potato yield', 'improved crop quality'],
    howToUse: [
      'apply powder on soil',
      'apply water until water is passed through'
    ],
    price: 3000,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i4',
    category: ['c3'],
    title: 'Asilee Fertelizer',
    type: DawaType.fertelizer,
    imageLink: 'assets/asilee.jpeg',
    benefits: [
      'increases soil fertility',
      'builds soil structure and water retention capacity',
      'increases nutrients in soil'
    ],
    howToUse: [
      'apply 100g per crop after planting',
      'Once a day',
      'repeat for 3 weeks'
    ],
    price: 6000,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i5',
    category: ['c3'],
    title: 'Organic Earthlee Maure',
    type: DawaType.fertelizer,
    imageLink: 'assets/earthlee new.jpeg',
    benefits: [
      'enhanced nutrient transfer (phosphates, iron, calcium)',
      'enhanced soil poration',
      'increase water retention capacity'
    ],
    howToUse: ['apply 1 kg of manure on soil'],
    price: 10000,
    agroPhoneNumber: 072093735,
  ),
];
