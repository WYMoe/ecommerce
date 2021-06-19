
import 'package:ecommerce/provider/cart.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier{

  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(
      {String id, double amount, List<CartItem> item, DateTime dateTime}){
    _orders.insert(0, Order(id: id, amount: amount, products: item, dateTime: dateTime));
    notifyListeners();
  }
}
