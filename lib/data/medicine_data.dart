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
    color: Color.fromARGB(255, 181, 81, 45),
  ),
  DiseaseCategory(
    id: 'c4',
    title: 'Pests (Aphids, worms etc)',
    color: Color.fromARGB(255, 102, 8, 115),
  ),
  DiseaseCategory(
    id: 'c3',
    title: 'Suppliments, Fertelizers',
    color: Color.fromARGB(255, 81, 153, 118),
  ),
];

// data on the medicine

List<Dawa> dummyMedicine = [
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
    category: ['c2'],
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
  Dawa(
    id: 'i6',
    category: ['c1'],
    title: 'Achook Neaticide',
    type: DawaType.nematicide,
    imageLink: 'assets/Achook_nematicide.jpg',
    benefits: [
      'Low toxicity chemical ',
      'Kills bacteria that causes early blight in potato leaves',
    ],
    howToUse: ['mix 100ml with 5L of water and spray'],
    price: 210,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i7',
    category: ['c4'],
    title: 'Ampligo Insecticide',
    type: DawaType.insecticide,
    imageLink: 'assets/ampligo insecticide.png',
    benefits: [
      'Kills arphids',
      'Does not burn stems of plant',
    ],
    howToUse: ['apply powder on black spots of plant'],
    price: 800,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i8',
    category: ['c1'],
    title: 'Athea Fungiside',
    type: DawaType.fungiside,
    imageLink: 'assets/arthea fungicide.png',
    benefits: [
      'Controls fungi from spreading',
    ],
    howToUse: ['apply chemical in 10L of water and spray'],
    price: 1800,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i9',
    category: ['c3'],
    title: 'Asilee Organic Soil Conditioner',
    type: DawaType.fertelizer,
    imageLink: 'assets/Asilee_Organic_Soil_Conditioner.png',
    benefits: ['enhanced soil poration', 'increase water retention capacity'],
    howToUse: ['apply manure in soil and water'],
    price: 7800,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i10',
    category: ['c4'],
    title: 'Karate 5CS Insecticide',
    type: DawaType.insecticide,
    imageLink: 'assets/karate insects.png',
    benefits: [
      'low toxicity chemical',
      'instantly kills insects on crop leaves and stems'
    ],
    howToUse: ['mix with 5L of water and spray directly'],
    price: 900,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i11',
    category: ['c4'],
    title: 'Kelpag Organic seaweed',
    type: DawaType.nematicide,
    imageLink: 'assets/Kelpak_organic_seaweed.jpg',
    benefits: [
      'applies toxic smell on plant that repells pests ',
      'improves plant health'
    ],
    howToUse: ['mix with 5L of water and spray directly'],
    price: 2500,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i11',
    category: ['c3'],
    title: 'Kleanup Charcoal Deactivator',
    type: DawaType.fertelizer,
    imageLink: 'assets/kleanup Charcoal deactivator.jpg',
    benefits: ['improves soil quality'],
    howToUse: ['mix with 5L of water and pour on soil directly'],
    price: 8000,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i12',
    category: ['c2'],
    title: 'Serenade Insecticide',
    type: DawaType.insecticide,
    imageLink: 'assets/serenade-insecticide.jpg',
    benefits: ['low toxicity', 'biogradable'],
    howToUse: ['mix with 5L of water and spray'],
    price: 1000,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i13',
    category: ['c1', 'c4'],
    title: 'Thovit Fungicide',
    type: DawaType.fungiside,
    imageLink: 'assets/thiovit fungicide.png',
    benefits: [
      'controls early blight potato and tomatoes disease',
      'biogradable',
      'highly effective against powdery mildew',
      'surpresses mites'
    ],
    howToUse: ['pour directly on infected leaves'],
    price: 550,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i14',
    category: ['c4'],
    title: 'Triggard Powder',
    type: DawaType.insecticide,
    imageLink: 'assets/trigard 75wp.png',
    benefits: ['non-flammable', 'controls larvae'],
    howToUse: ['apply powder on dark areas of leaves and stem'],
    price: 1900,
    agroPhoneNumber: 072093735,
  ),
  Dawa(
    id: 'i15',
    category: ['c2'],
    title: 'Volium Targo ',
    type: DawaType.nematicide,
    imageLink: 'assets/volium targo.png',
    benefits: [
      'non-flammable',
      'controls larvae'
          'superior leaf rust control'
    ],
    howToUse: ['mix chemical with 10L of water and spray'],
    price: 1900,
    agroPhoneNumber: 072093735,
  ),
];
