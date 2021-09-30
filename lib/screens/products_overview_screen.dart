import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/provider/product_model.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/badge_widget.dart';
import 'package:ecommerce/widgets/product_item_widget.dart';
import 'package:ecommerce/widgets/products_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum filterOptions { all, favourites }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFav = false;
  bool _isDoneLoading = false;
  bool _isLoading = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    if (!_isDoneLoading) {
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<ProductsProvider>(context).fetchProduct();

      } catch (err) {
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
       
      }
    }

    _isDoneLoading = true;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('All'),
                value: filterOptions.all,
              ),
              PopupMenuItem(
                child: Text('Favourites'),
                value: filterOptions.favourites,
              )
            ],
            onSelected: (filterOptions f) {
              if (f == filterOptions.all) {
                setState(() {
                  _showFav = false;
                });
              } else {
                setState(() {
                  _showFav = true;
                });
              }
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) {
              return BadgeWidget(
                  child: ch, value: cart.totalQuantity.toString());
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGridWidget(
              showFav: _showFav,
            ),
    );
  }
}
