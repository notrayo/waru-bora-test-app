import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key, required this.onSelectScreenFromDrawer});

  //logic for switching screens
  final void Function(String identifier) onSelectScreenFromDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(
              children: [
                const Icon(
                  Icons.grass_outlined,
                  size: 45,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'WARU BORA ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          //add content to drawer

          ListTile(
            leading: const Icon(
              Icons.home_filled,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Home Page',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state

              //close drawer
              onSelectScreenFromDrawer('Home');
            },
          ),

          //Adding Favourites

          ListTile(
            leading: const Icon(
              Icons.stars,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'My Favourites',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Favourites');

              //close drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart_checkout,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'My Cart',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Cart');

              //close drawer
              //Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Placed Orders',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Orders');

              //close drawer
              //Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.person_outline,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              ' My Profile',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Profile');

              //close drawer
              //Navigator.pop(context);
            },
          ),

          // Cart Page

          ListTile(
            leading: const Icon(
              Icons.chat,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Contact Us!',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Chat');

              //close drawer
              // Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.star_half_sharp,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              ' Rate Us !',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () {
              //control state
              onSelectScreenFromDrawer('Ratings');

              //close drawer
              //Navigator.pop(context);
            },
          ),

          const SizedBox(
            height: 30,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
            onTap: () async {
              //firebase logout
              await FirebaseAuth.instance.signOut();
              // Perform logout action here
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              // Navigate back to login screen
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', ((route) => false));
            },
          ),
        ],
      ),
    );
  }
}
