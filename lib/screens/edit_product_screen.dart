import 'package:ecommerce/provider/product_model.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product-screen";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _urlFocusNode = FocusNode();
  final _urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _tempTitle;
  String _tempDescription;
  double _tempPrice;
  String _tempImageUrl;
  String _tempId;
  bool _tempFav;


  bool _isDoneLoading=false;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _urlFocusNode.addListener(updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_isDoneLoading) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        var product =
            Provider.of<ProductsProvider>(context).findById(productId);
        _tempId = product.id;
        _tempTitle = product.title;
        _tempImageUrl = product.imageUrl;
        _tempDescription = product.description;
        _tempPrice = product.price;
        _tempFav = product.isFavourite;
        _urlController.text = product.imageUrl;

      }
    }
    _isDoneLoading = true;
    super.didChangeDependencies();
  }

  updateImage() {
    if (!_urlFocusNode.hasFocus) {
      if ((!_urlController.text.startsWith('http') &&
          !_urlController.text.startsWith('https'))) {
        return;
      }
      setState(() {

      });
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_tempId == null) {
        setState(() {
          _isLoading = true;
        });
        try{
          ProductModel productModel = ProductModel(
              id: DateTime.now().toString(),
              title: _tempTitle,
              price: _tempPrice,
              imageUrl: _tempImageUrl,
              description: _tempDescription);
        await Provider.of<ProductsProvider>(context, listen: false)
              .addProduct(productModel);
        }catch(err){
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An error occurred!'),
              content: Text('Something went wrong.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
        }finally{
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        }

      } else {
        ProductModel productModel = ProductModel(
            id: _tempId,
            title: _tempTitle,
            price: _tempPrice,
            imageUrl: _tempImageUrl,
            description: _tempDescription,
            isFavourite: _tempFav);
        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_tempId, productModel);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _urlController.dispose();
    _urlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        ):Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: _tempTitle,
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _tempTitle = val;
                        },
                      ),
                      TextFormField(
                        initialValue:
                            _tempPrice != null ? _tempPrice.toString() : "",
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a price.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number.';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please enter a number greater than zero.';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          _tempPrice = double.parse(val);
                        },
                      ),
                      TextFormField(
                          initialValue: _tempDescription,
                          decoration: InputDecoration(labelText: 'Description'),
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a description.';
                            }
                            if (value.length < 10) {
                              return 'Should be at least 10 characters long.';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _tempDescription = val;
                          }),
                      Row(
                        children: [
                          Container(
                              width: 100.0,
                              height: 100.0,
                              margin: EdgeInsets.only(top: 8.0, right: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.blueGrey,
                                width: 1.0,
                              )),
                              child: _urlController.text.isEmpty
                                  ? Center(child: Text("Enter URL"))
                                  : FittedBox(
                                      child: Image.network(
                                        _urlController.text.toString(),
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'URL',
                              ),
                              textInputAction: TextInputAction.done,
                              controller: _urlController,
                              focusNode: _urlFocusNode,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter an image URL.';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please enter a valid URL.';
                                }
                                // if (!value.endsWith('.png') &&
                                //     !value.endsWith('.jpg') &&
                                //     !value.endsWith('.jpeg')) {
                                //   return 'Please enter a valid image URL.';
                                // }
                                return null;
                              },
                              onSaved: (val) {
                                _tempImageUrl = val;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextButton(
                          onPressed: () {
                            saveForm();
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]),
              )),
        ));
  }
}
