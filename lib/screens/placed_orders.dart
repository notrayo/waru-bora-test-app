import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import '../models/orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class OrderData {
  final String orderId;
  final String items;
  final double totalPrice;
  final DateTime orderDate;

  OrderData({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
  });
}

class _OrdersScreenState extends State<OrdersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<OrderData>> getUserOrders() async {
    final User? user = _auth.currentUser;
    final email = user?.email;

    if (email != null) {
      final querySnapshot = await _firestore
          .collection('orders')
          .where('email', isEqualTo: email)
          .get();

      final orders = querySnapshot.docs.map((doc) {
        final data = doc.data();
        final totalPrice = data['totalPrice'].toDouble();
        final timeStamp = (data['orderDate'] as Timestamp).toDate();
        return OrderData(
          orderId: doc.id,
          items: data['items'],
          totalPrice: totalPrice,
          orderDate: timeStamp,
        );
      }).toList();

      return orders;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: FutureBuilder(
        future: getUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child:
                  Text('Error fetching orders: ${snapshot.error.toString()}'),
            );
          } else if (snapshot.hasData) {
            final orders = snapshot.data as List<OrderData>;

            if (orders.isEmpty) {
              return const Center(
                child: Text('No orders found'),
              );
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

//widget

class OrderCard extends StatelessWidget {
  final OrderData order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Price: ${order.totalPrice}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Date Ordered: ${order.orderDate}',
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 8),
            Text(
              'Items Placed: ${order.items}',
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Delete Order'),
              content:
                  const Text('Are you sure you want to delete this order?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    deleteOrder(order.orderId);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> deleteOrder(String orderId) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .delete();
    }
  }
}
