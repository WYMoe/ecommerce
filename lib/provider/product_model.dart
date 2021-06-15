import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
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
      this.isFavourite = false});

  void toggleFavourite(){
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
