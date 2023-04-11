import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // syntax for highlighting whenever an icon is clicked

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WARU BORA APP'),
      ),
      //body: const Text('app contents here : '),
      //bottom nav bar

      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined), label: 'diagnosis'),
            BottomNavigationBarItem(
                icon: Icon(Icons.energy_savings_leaf_outlined),
                label: 'treatment'),
          ]),
    );
  }
}
