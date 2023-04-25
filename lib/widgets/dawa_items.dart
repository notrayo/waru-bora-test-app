import 'package:flutter/material.dart';

import '../models/dawa.dart';

class DawaItem extends StatelessWidget {
  const DawaItem({
    super.key,
    required this.id,
    required this.category,
    required this.title,
    required this.type,
    required this.imageLink,
    required this.price,
  });

  final String id;
  final List<String> category;
  final String title;
  final DawaType type;
  final String imageLink;
  //final List<String> benefits;
  //final List<String> howToUse;
  final int price;
  //final int agroPhoneNumber;

  //fow when ontap is activated

  void selectMedicine() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectMedicine,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.asset(
                  imageLink,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
