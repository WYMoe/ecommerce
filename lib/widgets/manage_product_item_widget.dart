
import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductItemWidget extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;


  ManageProductItemWidget({this.id, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
        child: ListTile(
          leading: Container(
            width: MediaQuery.of(context).size.width*0.15,
            height: MediaQuery.of(context).size.height*0.15,
            margin: const EdgeInsets.all(5.0),

            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),

                child: Image.network(imageUrl,fit: BoxFit.fill,)),
          ),
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: Icon(Icons.edit), onPressed: (){
                Navigator.pushNamed(context, EditProductScreen.routeName,arguments: id);

              }),
              IconButton(icon: Icon(Icons.delete), onPressed: (){
                showDialog(
                    context: (context),
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text("No")),
                          TextButton(
                              onPressed: () {
                                Provider.of<ProductsProvider>(context,listen: false).deleteProduct(id);
                                Navigator.of(context).pop(true);
                              },
                              child: Text("Yes"))
                        ],
                      );
                    });
              })
            ],
          ),

        ),
      ),
    );
  }
}
