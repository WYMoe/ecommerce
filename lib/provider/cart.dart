import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int getItemCount(){
    return _items==null ? 0: _items.length;
  }

  int getTotalQuantity(){
    int i = 0;
    _items.values.forEach((cart) {
      i+= cart.quantity;
    });
    return i;
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity+1,
              price: price));

    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(id: DateTime.now().toString(), title: title, quantity: 1, price: price),
      );

    }
    notifyListeners();

  }
}
