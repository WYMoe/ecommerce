import 'dart:convert';

import 'package:ecommerce/provider/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _items = [];

  List<ProductModel> get items => [..._items];
  ProductModel findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<ProductModel> showFav() {
    return _items.where((prod) => prod.isFavourite == true).toList();
  }

  Future<void> addProduct(ProductModel productModel) async {
    var url = Uri.parse(
        "https://e-commercev2-f6c36-default-rtdb.firebaseio.com/products.json");
    try {
      var response = await http.post(url,
          body: json.encode({
            "title": productModel.title,
            "description": productModel.description,
            "price": productModel.price,
            "imageUrl": productModel.imageUrl,
            "isFavourite": productModel.isFavourite
          }));
      final newProduct = ProductModel(
          title: productModel.title,
          id: jsonDecode(response.body)['name'], //get id from firebase
          isFavourite: productModel.isFavourite,
          description: productModel.description,
          imageUrl: productModel.imageUrl,
          price: productModel.price);
      _items.add(productModel);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  fetchProduct() async {
    var url = Uri.parse(
        "https://e-commercev2-f6c36-default-rtdb.firebaseio.com/products.json");
    try {
      var response = await http.get(url);
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      List<ProductModel> loadedData = [];
      data.forEach((id, productData) {
        loadedData.add(ProductModel(
            id: id,
            title: productData['title'],
            imageUrl: productData['imageUrl'],
            isFavourite: productData['isFavourite'],
            price: productData['price'],
            description: productData['description']));
      });
      _items = loadedData;
      notifyListeners();
    } catch (err) {
      throw (err);
    }


  }

  void updateProduct(String id, ProductModel productModel) {
    int index = _items.indexWhere((p) => p.id == id);

    if (index >= 0) {
      _items[index] = productModel;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
