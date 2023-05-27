import 'package:flutter/material.dart';

//import 'package:flutter_cart/flutter_cart.dart';
import 'package:waru_bora_test/screens/checkout_screen.dart';
//import './madawa_details_screen.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

//saving order info to firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //firebase initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? currentUser;
  //StreamSubscription<User?>? _authSubscription;

  // @override
  // void initState() {
  //   super.initState();
  //   // Listen to user authentication changes
  //   _authSubscription = _auth.authStateChanges().listen((User? user) {
  //     if (mounted) {
  //       setState(() {
  //         currentUser = user; // Update the current user
  //       });

  //       if (user == null) {
  //         // User logged out, clear the cart
  //         Provider.of<Cart>(context, listen: false).clear();
  //       }
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   // Cancel the Firebase listener to avoid calling setState after dispose
  //   _authSubscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    //total amount
    final totalAmount = cart.totalPrice.toStringAsFixed(2);

    Future<void> saveOrder() async {
      // Get the current user
      final User? user = _auth.currentUser;

      if (user != null) {
        // Convert the cart items to a comma-separated string
        final itemTitles =
            cart.items.values.map((cartItem) => cartItem.title).join(', ');

        //get info from orders table
        final String email = user.email!;

        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: email)
                .limit(1)
                .get();

        String? phoneNumber;

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot<Map<String, dynamic>> snapshot =
              querySnapshot.docs.first;

          phoneNumber = snapshot.get('phoneNumber');

          // Use the retrieved data as needed.
          //print('First Name: $firstName');
          //print('Last Name: $lastName');
          //print('Phone Number: $phoneNumber');
        }
        // Get the current date and time
        final orderDate = DateTime.now();

        // Create a new order document
        final newOrder = {
          'email': user.email,
          'items': itemTitles,
          'totalPrice': cart.totalPrice,
          'orderDate': orderDate,
          'phoneNumber': phoneNumber,
        };

        try {
          // Add the new order to the "orders" collection
          await _firestore.collection('orders').add(newOrder);
          // Show a success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Order placed successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        } catch (error) {
          // Handle any errors that occur
          print('Error saving order: $error');
        }
      }
    }

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
                      return Builder(builder: (context) {
                        final cartItem = cart.items.values.toList()[i];
                        return Dismissible(
                          key: Key(cart.items.values.toList()[i].id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            Provider.of<Cart>(context, listen: false)
                                .removeItem(cart.items.keys.toList()[i]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "${cartItem.title} removed from cart!"),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: ListTile(
                            title: Text(cartItem.title),
                            subtitle: Text('${cartItem.quantity} items'),
                            trailing: Text('Ksh ${cartItem.price}'),
                          ),
                        );
                      });
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
          saveOrder();
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
