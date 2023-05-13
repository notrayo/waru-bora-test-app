import 'package:waru_bora_test/models/dawa.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartState {
  final List<Dawa> items;
  CartState(this.items);
}

class MedicineCart extends StateNotifier<CartState> {
  MedicineCart() : super(CartState([]));

  //get cartItems => null;

  void addItem(Dawa item) {
    state = CartState([...state.items, item]);
  }

  void removeItem(Dawa item) {
    state = CartState([...state.items]..remove(item));
  }

  int get itemCount => state.items.length;

  double get totalPrice =>
      state.items.fold(0.0, (total, item) => total + item.price);

  //int get cartItemsCount => state.length;
}

final medicineCartProvider =
    StateNotifierProvider<MedicineCart, CartState>((ref) {
  return MedicineCart();
});
