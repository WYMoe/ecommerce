
import 'package:ecommerce/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemWidget(
  { this.id,
      this.productId,
      this.price,
      this.quantity,
      this.title,}
      );
  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),

      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: FittedBox(
                   child: Text(
                     '\$ $price'
                   ),
                 ),
               ),

            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(width: 10.0,),
                IconButton(icon: Icon(Icons.remove), onPressed: (){
                    Provider.of<Cart>(context,listen: false).reduceQunatity(id);
                }),
                Text('$quantity'),
                IconButton(icon: Icon(Icons.add), onPressed: (){
                  Provider.of<Cart>(context,listen: false).addItem(id, title, price);

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
