import 'package:flutter/material.dart';

import '../models/dawa.dart';

import '../screens/madawa_details_screen.dart';
//import '../screens/favs_screen.dart';

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

  String get dawaTypeText {
    switch (type) {
      case DawaType.fertelizer:
        {
          return 'fertelizer';
        }
      case DawaType.fungiside:
        {
          return 'fungiside';
        }
      case DawaType.insecticide:
        {
          return 'insecticide';
        }
      default:
        return 'Unknown';
    }
  }

  //for when ontap is activated

  void selectMedicine(BuildContext context) {
    Navigator.of(context).pushNamed(DawaDetailsScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 235, 234, 234)),
        child: InkWell(
          onTap: () => selectMedicine(context),
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
                  ),
                  Positioned(
                    bottom: 8,
                    left: 10,
                    child: Container(
                      width: 320,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text(
                        title,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    //Icon(Icons.local_dining_outlined),
                    //SizedBox(
                    //width: 4,
                    //),
                    const Icon(Icons.category_outlined),
                    const SizedBox(width: 10),
                    Text(dawaTypeText),
                    const SizedBox(width: 10),
                    const Icon(Icons.paid_outlined),
                    const SizedBox(width: 10),
                    Text('Ksh ${price.toString()}'),
                    const SizedBox(width: 4),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
