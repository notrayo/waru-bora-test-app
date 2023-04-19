import 'package:flutter/material.dart';

// for type of medicine

enum DawaType { fungiside, insecticide, fertelizer }

class Dawa {
  final String id;
  final List<String> category;
  final String title;
  final DawaType type;
  final String imageLink;
  final List<String> benefits;
  final List<String> howToUse;
  final int price;
  final int agroPhoneNumber;
  // final ... googlemaps url

  const Dawa(
      {required this.id,
      required this.category,
      required this.title,
      required this.type,
      required this.imageLink,
      required this.benefits,
      required this.howToUse,
      required this.price,
      required this.agroPhoneNumber});
}
