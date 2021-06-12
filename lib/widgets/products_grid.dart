import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final loadedProducts = products.items;
    return GridView.builder(
        itemCount: loadedProducts.length,
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            title: loadedProducts[index].title,
            id: loadedProducts[index].id,
            imageUrl: loadedProducts[index].imageUrl,
          );
        });
  }
}
