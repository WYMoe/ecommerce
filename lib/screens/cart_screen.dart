import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/provider/orders.dart';
import 'package:ecommerce/widgets/cart_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Chip(label: Text('${cart.totalAmount.toString()}\$')),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        cart.items.forEach((id, cartItem) {
                          if (cartItem.quantity <= 0) {
                            cart.removeItem(id);

                          }
                        });
                        if (cart.items.values.toList().length > 0) {

                          Provider.of<Orders>(context, listen: false).addOrder(
                              id: DateTime.now().toString(),
                              dateTime: DateTime.now(),
                              amount: cart.totalAmount,
                              item: cart.items.values.toList());
                          cart.clearCart();
                        }
                      },
                      child: Text('Order Now'))
                ],
              ),
            ),
          ),
          ListView.builder(
              itemCount: cart.itemCount,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  id: cart.items.keys.toList()[index],
                  price: cart.items.values.toList()[index].price,
                  productId: cart.items.values.toList()[index].id,
                );
              })
        ],
      ),
    );
  }
}
