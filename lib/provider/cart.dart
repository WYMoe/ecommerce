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

  int get itemCount{
    return _items==null ? 0: _items.length;
  }

  int get totalQuantity{
    int i = 0;
    _items.values.forEach((cart) {
      i+= cart.quantity;
    });
    return i;
  }

  double get totalAmount{
    double amount = 0;
    _items.values.forEach((cart) {
      amount+= cart.quantity* cart.price;
    });
    return amount;
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

  void removeItem(String id){
    _items.remove(id);
    notifyListeners();

  }

  void reduceQunatity(String id){

      _items.update(
          id,
              (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity<=0 ? 0 :existingCartItem.quantity-1,
              price: existingCartItem.price));

      notifyListeners();

  }
}
