import 'package:flutter/material.dart';
import 'package:waru_bora_test/data/medicine_data.dart';
//import '../screens/cart.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:waru_bora_test/screens/cart.dart';
import '../models/dawa.dart';
import '../models/cart.dart';

import 'package:provider/provider.dart';

//import '../providers/cart_state_notifier.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:provider/provider.dart';
//import 'package:riverpod_context/riverpod_context.dart';

class DawaDetailsScreen extends StatefulWidget {
  static const routeName = '/dawa-detail';

  const DawaDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DawaDetailsScreen> createState() => _DawaDetailsScreenState();
}

class _DawaDetailsScreenState extends State<DawaDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dawaID = ModalRoute.of(context)?.settings.arguments as String;

    final selectedMedicine =
        // ignore: non_constant_identifier_names
        dummyMedicine.firstWhere((Dawa) => Dawa.id == dawaID);

    double listViewHeight = selectedMedicine.benefits.length * 60.0 + 10.0;

    double listViewHeight2 = selectedMedicine.howToUse.length * 60.0 + 10.0;

    //riverpod state notifier..

    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: (Scaffold(
        appBar: AppBar(
          title: Text(selectedMedicine.title),
          actions: [
            Consumer<Cart>(
              builder: (context, cart, child) => IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 31,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          cart.totalItems.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          //cart icon
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  selectedMedicine.imageLink,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.85, // adjust the width to make it smaller
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: const Color.fromARGB(255, 242, 242, 242),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Ksh ${selectedMedicine.price.toString()}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 3, 115, 50),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: GestureDetector(
                  onTap: (() {
                    final cart = Provider.of<Cart>(context, listen: false);
                    cart.addItem(selectedMedicine.title, selectedMedicine.id,
                        selectedMedicine.price);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item added to cart'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }),
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.85, // adjust the width to make it smaller
                    height: MediaQuery.of(context).size.height * 0.085,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: const Color.fromARGB(255, 242, 242, 242),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add To Cart',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Icon(
                          Icons.add,
                          size: 32,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.85, // adjust the width to make it smaller
                    height: MediaQuery.of(context).size.height * 0.08,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: const Color.fromARGB(255, 242, 242, 242),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add To Favourites',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        StarButton(
                            isStarred: selectedMedicine.isStarred,
                            valueChanged: (isStarred) {
                              setState(() {
                                selectedMedicine.isStarred = isStarred;
                              });

                              //snackbar
                              final snackBar = SnackBar(
                                content: Text(
                                  isStarred
                                      ? 'Added to favorites!'
                                      : 'Removed from favorites!',
                                ),
                                duration: const Duration(seconds: 2),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              print('Is Favorite $isStarred)');
                            })
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Benefits',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 123, 84, 70),
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: listViewHeight,
                width: 350,
                child: ListView.builder(
                    itemBuilder: (context, index) => Card(
                          color: const Color.fromARGB(255, 136, 184, 206),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(selectedMedicine.benefits[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                          ),
                        ),
                    itemCount: selectedMedicine.benefits.length),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'How To Use',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 83, 204, 12),
                    //decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: listViewHeight2,
                width: 350,
                child: ListView.builder(
                    itemBuilder: (context, index) => Card(
                          color: const Color.fromARGB(255, 92, 142, 99),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(selectedMedicine.howToUse[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                          ),
                        ),
                    itemCount: selectedMedicine.howToUse.length),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
