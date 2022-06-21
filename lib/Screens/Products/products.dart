import 'package:flutter/material.dart';
import 'package:fyp/Screens/Products/Components/body.dart';
import 'package:fyp/Screens/Products/Components/view_products_screen.dart';
import 'package:fyp/constants.dart';

class ProductScreen extends StatelessWidget {
  //const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Products"),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   foregroundColor: hintColor,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      // ),
      body: ViewProductScreen(),
    );
  }
}
