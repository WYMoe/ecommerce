import 'package:ecommerce/provider/cart.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/edit_product_screen.dart';
import 'package:ecommerce/screens/manage_product_screen.dart';
import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:ecommerce/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProductsProvider()),
        ChangeNotifierProvider(create: (_)=> Cart()),
        ChangeNotifierProvider(create: (_) => Orders())


      ],
      child: MaterialApp(
        title: 'Ecommerce',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName:(context) => CartScreen(),
          OrdersScreen.routeName:(context) => OrdersScreen(),
          ManageProductScreen.routeName:(context) => ManageProductScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen()
        },
      ),
    );
  }
}
