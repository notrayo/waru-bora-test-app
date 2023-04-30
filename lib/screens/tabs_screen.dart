import 'package:flutter/material.dart';
import './diagnosis_screen.dart';
import './treatment_screen.dart';
import './home_screen.dart';
import './drawer_screen.dart';
import './profile_screen.dart';
import './settings_screen.dart';
import './favs_screen.dart';
import './cart.dart';

//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // syntax for highlighting whenever an icon is clicked

  final List<Map<String, Object>> _pages = [
    {'page': const HomeScreen(), 'title': 'HOME PAGE'},
    {'page': const DiagnosisScreen(), 'title': 'DIAGNOSIS PAGE'},
    {'page': const TreatmentScreen(), 'title': 'TREATMENT PAGE'}
  ];

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //syntax for switching pages from drawer

  void _selectScreenFromDrawer(String identifier) {
    if (identifier == 'Home') {
      Navigator.of(context).pop();
      setState(() {
        _selectedPageIndex = 0;
      });
      //favourites...
    } else if (identifier == 'Favourites') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FavsScreen(),
      ));

      //Cart
    } else if (identifier == 'Cart') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CartPage(),
      ));
    } else if (identifier == 'Profile') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ));
    } else if (identifier == 'Settings') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ));
    } else {
      Navigator.of(context).pop();
    }
    //set state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String? ?? ''),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget?,
      //adding drawer
      drawer: DrawerScreen(
        onSelectScreenFromDrawer: _selectScreenFromDrawer,
      ),

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
