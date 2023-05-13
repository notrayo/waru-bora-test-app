import 'package:flutter/material.dart';

import 'package:flutter_cart/flutter_cart.dart';
import './madawa_details_screen.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // final List<CartItem> items = cart.getCart();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: const Center(
        child: Text('Items added to the cart will appear here ...'),
      ),
    );
  }
}
