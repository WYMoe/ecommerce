import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: (){
            Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: id);
          },
          child: Image.network(imageUrl,
          fit: BoxFit.cover,),
        ),
        footer: GridTileBar(
          title: Text(title,textAlign: TextAlign.center,),
          backgroundColor: Colors.black54,
          leading: Icon(Icons.favorite),
          trailing: Icon(Icons.shopping_cart_outlined),

        ),

      ),
    );
  }
}
