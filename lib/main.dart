import 'package:flutter/material.dart';
import '/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'waru bora',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),

      initialRoute: '/',

      routes: {'/': (context) => const TabScreen()},
      //home: const HomeScreen(),
    );
  }
}
