import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridWidget extends StatelessWidget {
  final bool showFav;

  ProductGridWidget({this.showFav});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context,listen: false);
    final loadedProducts = showFav? products.showFav(): products.items;
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

          
          return ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: ProductItemWidget(


            ),
          );
        });
  }
}
