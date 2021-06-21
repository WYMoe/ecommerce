
import 'package:flutter/material.dart';

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

              }),
              IconButton(icon: Icon(Icons.delete), onPressed: (){

              })
            ],
          ),

        ),
      ),
    );
  }
}
