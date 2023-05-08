import 'package:flutter/material.dart';
import '../data/medicine_data.dart';
import '../models/dawa.dart';
import '../widgets/dawa_items.dart';

class FavsScreen extends StatefulWidget {
  const FavsScreen({Key? key}) : super(key: key);

  @override
  State<FavsScreen> createState() => _FavsScreenState();
}

class _FavsScreenState extends State<FavsScreen> {
  List<Dawa> _favoriteMedicines = [];

  @override
  void initState() {
    super.initState();
    _favoriteMedicines =
        dummyMedicine.where((medicine) => medicine.isStarred).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('YOUR FAVOURITES'),
        ),
        body: _favoriteMedicines.isEmpty
            ? const Center(
                child: Text('No favorite medicines.'),
              )
            : ListView.builder(
                itemBuilder: ((context, index) => DawaItem(
                      id: _favoriteMedicines[index].id,
                      title: _favoriteMedicines[index].title,
                      imageLink: _favoriteMedicines[index].imageLink,
                      price: _favoriteMedicines[index].price,
                      category: _favoriteMedicines[index].category,
                      type: _favoriteMedicines[index].type,
                    )),
                itemCount: _favoriteMedicines.length,
              ));
  }
}
