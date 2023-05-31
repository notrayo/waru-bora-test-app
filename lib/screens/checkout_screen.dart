import 'package:flutter/material.dart';
import 'package:waru_bora_test/screens/ratings_screen.dart';
//import 'package:waru_bora_test/screens/home_screen.dart';
//import 'package:waru_bora_test/screens/tabs_screen.dart';
import '../models/cart.dart';
import 'package:provider/provider.dart';

import 'location_maps_screen.dart';
//import '../screens/cart_screen.dart';
//calling via app
import 'package:url_launcher/url_launcher.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  void openGoogleMaps() async {
    const url =
        'https://www.google.com/maps/dir/?api=1&destination=-1.2499801,36.6749099';
    // Replace 'latitude' and 'longitude' with the actual coordinates of the destination
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final total = cart.totalPrice.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Total Amount to Pay : Ksh $total',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Text(
                  '  PAY VIA M-PESA',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 34, 33, 33)),
                )
              ],
            ),
            Image.asset('assets/Lipanampesa.png'),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
                side: const BorderSide(color: Colors.green, width: 2),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'BUY GOODS TILL NO  : 838 876',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'TILL NAME  : ORGANIX LMTD KIKUYU',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  '  PAY VIA CASH',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 34, 33, 33)),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Contact / Call Us : ',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 69, 69),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async {
                // const phoneNumber = '0791 266 895';
                // final cleanedPhoneNumber = phoneNumber.replaceAll(' ', '');

                // final Uri url = Uri(scheme: 'tel', path: cleanedPhoneNumber);

                // if (await canLaunchUrl(url)) {
                //   await launchUrl(url);
                // } else {
                //   throw 'cannot launch phone dialer';
                // }

                const phoneNumber = '0791266895';
                const url = 'tel:$phoneNumber';

                launch(url);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const MapsScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 56, 143, 2),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '0736 190 951',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(
                      Icons.call,
                      size: 35,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Maps Direction : ',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 69, 69, 69),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                openGoogleMaps();
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 56, 143, 2),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Google',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Maps',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(
                      Icons.location_on_sharp,
                      size: 35,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  '  PLEASE PAY BEFORE COMPLETING ...',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 56, 7)),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          //saveOrder();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RatingsScreen()),
          );
        },
        child: Container(
          color: const Color.fromARGB(255, 76, 217, 41),
          alignment: Alignment.center,
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(width: 5.0),
              Text(
                '  COMPLETE TRANSACTION',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
