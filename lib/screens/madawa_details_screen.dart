import 'package:flutter/material.dart';
import 'package:waru_bora_test/data/medicine_data.dart';
import '../screens/cart.dart';
import 'package:favorite_button/favorite_button.dart';
import '../models/dawa.dart';

class DawaDetailsScreen extends StatefulWidget {
  static const routeName = '/dawa-detail';

  const DawaDetailsScreen({super.key});

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

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMedicine.title),
          actions: [
            StarButton(
                isStarred: selectedMedicine.isStarred,
                valueChanged: (isStarred) {
                  setState(() {
                    selectedMedicine.isStarred = isStarred;
                  });
                  print('Is Favorite $isStarred)');
                })
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
                height: 15,
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
                height: 15,
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
        ));
  }
}
