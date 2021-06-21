import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/manage_product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatelessWidget {
  static const routeName = "/manage-product-screen";
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context,index){
        return ManageProductItemWidget(
          title: products[index].title,
          id: products[index].id,
          imageUrl: products[index].imageUrl,
        ) ;
      }),
    );
  }
}
