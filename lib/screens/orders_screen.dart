
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/orders.dart';
class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders-screen";


  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar:AppBar(
        title: Text('My Orders'),
      ) ,
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context,index){
            return OrderItemWidget(
              id: orders[index].id,
              amount: orders[index].amount,
              products: orders[index].products,
              dateTime: orders[index].dateTime,
            );
          }),
    );
  }
}
