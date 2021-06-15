import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/provider/product_model.dart';
import 'package:ecommerce/widgets/badge.dart';
import 'package:ecommerce/widgets/product_item.dart';
import 'package:ecommerce/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum filterOptions { all, favourites }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),

        actions: [
          PopupMenuButton(

           itemBuilder: (context)=>[
             PopupMenuItem(child: Text('All'),
             value: filterOptions.all,
             ),
             PopupMenuItem(child: Text('Favourites'),
             value: filterOptions.favourites,)

           ],
            onSelected: (filterOptions f){
             if(f == filterOptions.all){
               setState(() {
                 _showFav = false;
               });
              }else{
               setState(() {
                 _showFav = true;
               });

             }
            },
          ),
          Consumer<Cart>(
           builder: (_,cart,ch){
             return Badge(child: ch, value: cart.getTotalQuantity().toString());
           },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){

              },
            ),
          )

        ],

      ),
      body: ProductGrid(
        showFav: _showFav,
      ),
    );
  }
}
