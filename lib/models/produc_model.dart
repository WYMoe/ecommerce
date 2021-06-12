import 'package:flutter/cupertino.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  ProductModel(
      {@required this.id,
      @required this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavourite});
}
