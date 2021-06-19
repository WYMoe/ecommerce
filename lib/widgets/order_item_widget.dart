import 'dart:math';

import 'package:ecommerce/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatefulWidget {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItemWidget({this.id, this.amount, this.products, this.dateTime});

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text('\$ ${widget.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.dateTime)
                .toString()),
            trailing: IconButton(
              icon: isExpanded
                  ? Icon(Icons.expand_less)
                  : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          isExpanded
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      height:MediaQuery.of(context).size.height*0.1,
                      child: ListTile(
                        title: Text(widget.products[index].title),
                        trailing: Text(
                            "${widget.products[index].quantity} X ${widget.products[index].price}"),
                      ),
                    );
                  },
                )
              : SizedBox()
        ],
      ),
    );
  }
}
