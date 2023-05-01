import 'package:flutter/material.dart';
import '/screens/tabs_screen.dart';
//import '/screens/madawa_screen.dart';
import 'screens/madawa_details_screen.dart';
import './data/medicine_data.dart';

//firebase

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //favourites feature

  //List<Dawa> _favouriteMedicine = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'waru bora',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const TabScreen(),
        DawaDetailsScreen.routeName: (context) => const DawaDetailsScreen()
      },
      //home: const HomeScreen(),
    );
  }
}
