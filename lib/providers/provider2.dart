import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dawa.dart';

class DawaCartProvider extends StateNotifier<List<Dawa>> {
  DawaCartProvider() : super([]);

  void toggleDawaCartStatus(Dawa dawa) {
    final dawaAddedToCart = state.contains(dawa);

    if (dawaAddedToCart) {
      state = state.where((d) => d.id != dawa.id).toList();
    } else {
      state = [...state, dawa];
    }
  }
}

final dawaCartProvider =
    StateNotifierProvider<DawaCartProvider, List<Dawa>>((ref) {
  return DawaCartProvider();
});
