import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WARU BORA APP'),
      ),
      body: const Text('app contents here : '),
      //bottom nav bar

      bottomNavigationBar: BottomNavigationBar(
          //onTap:  ,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined), label: 'diagnosis'),
            BottomNavigationBarItem(
                icon: Icon(Icons.energy_savings_leaf_outlined),
                label: 'treatment'),
          ]),
    );
  }
}
