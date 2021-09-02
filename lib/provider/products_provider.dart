import 'package:ecommerce/provider/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _items = [
    ProductModel(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 50,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductModel(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 60,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductModel(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 20,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductModel(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 100,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<ProductModel> get items => [..._items];
  ProductModel findById (String id){
    return _items.firstWhere((product) => product.id==id);

  }

  List<ProductModel> showFav(){
    return _items.where((prod) => prod.isFavourite==true).toList();

  }

  void addProduct(ProductModel productModel) {
    _items.add(productModel);
    notifyListeners();
  }

  void updateProduct(String id,ProductModel productModel){
  int index = _items.indexWhere((p) => p.id==id);

  if(index>=0){
    _items[index]=productModel;
    notifyListeners();
  }

  }

  void deleteProduct(String id){
    _items.removeWhere((p) => p.id==id);
    notifyListeners();
  }
}
