import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'package:provider/provider.dart';
//import '../screens/cart_screen.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final total = cart.totalPrice.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: Text('Total amount: Ksh $total'),
      ),
    );
  }
}
