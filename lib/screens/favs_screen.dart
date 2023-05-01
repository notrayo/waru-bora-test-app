import 'package:flutter/material.dart';
import '../models/dawa.dart';

class FavsScreen extends StatelessWidget {
  const FavsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FavoriteItem> _favoriteItems = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAVOURITES'),
      ),
      body: _favoriteItems.isEmpty
          ? const Center(
              child: Text('No favorite items yet...'),
            )
          : ListView.builder(
              itemCount: _favoriteItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _favoriteItems[index];
                return ListTile(
                  leading: Image.asset(
                    item.imageLink,
                    height: 50,
                    width: 50,
                  ),
                  title: Text(item.title),
                  subtitle: Text('Ksh ${item.price.toString()}'),
                );
              },
            ),
    );
  }
}
