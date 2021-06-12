
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {

  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(id),
        ),
      ),
    );
  }
}
