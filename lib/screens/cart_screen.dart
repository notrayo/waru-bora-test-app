import 'package:flutter/material.dart';

import 'package:flutter_cart/flutter_cart.dart';
import 'package:waru_bora_test/screens/checkout_screen.dart';
import './madawa_details_screen.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    //total amount
    final totalAmount = cart.totalPrice.toStringAsFixed(2);

    // final List<CartItem> items = cart.getCart();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(
                    child: Text('Your cart is empty ...'),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, i) {
                      final cartItem = cart.items.values.toList()[i];
                      return Dismissible(
                        key: Key(cartItem.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          Provider.of<Cart>(context, listen: false)
                              .removeItem(cartItem.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("${cartItem.title} removed from cart!"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          title: Text(cartItem.title),
                          subtitle: Text('${cartItem.quantity} items'),
                          trailing: Text('Ksh ${cartItem.price}'),
                        ),
                      );
                    },
                  ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Ksh $totalAmount',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CheckoutPage()),
          );
        },
        child: Container(
          color: Colors.blue.shade800,
          alignment: Alignment.center,
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.attach_money,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(width: 5.0),
              Text(
                'PROCEED TO CHECKOUT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
