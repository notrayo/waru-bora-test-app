import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:countup/countup.dart';
import 'package:waru_bora_test/screens/location_maps_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('.... in partnership with ...'),
            const SizedBox(
              height: 25,
            ),
            Image.asset('assets/cropped-Organix-logo-edit.png'),
            const SizedBox(
              height: 25,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'About App: ',
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
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 7, 7, 7),
                  width: 0.3,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ML',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Accuracy',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Countup(
                    begin: 0,
                    end: 96,
                    duration: const Duration(seconds: 2),
                    separator: ',',
                    suffix: '%',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Locate Us : ',
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapsScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
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
              height: 25,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 25,
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
                          '0791 266 895',
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
          ],
        )),
      ),
    );
  }
}
