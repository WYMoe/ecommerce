import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/provider/product_model.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModel>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,

          ),
        ),



        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<ProductModel>(
            builder: (context, product, child) {
              return IconButton(
                  icon: product.isFavourite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavourite();
                  });
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('This item is added to cart'),
              duration: Duration(
                seconds: 2
              ),
              action: SnackBarAction(
                label: "Undo",
                onPressed: (){
                  cart.reduceQunatity(product.id);
                },
              ),));
            },
          ),
        ),
      ),
    );
  }
}
