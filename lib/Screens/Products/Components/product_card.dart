import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Products.dart';
import 'package:fyp/Screens/Products/Product_Details/product_details_screen.dart';
import 'package:fyp/constants.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  // final Function press;

  const ProductCard({
    Key? key,
    required this.product,
    // required this.press,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: hintColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.09),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.memory(
                base64.decode(widget.product.prod_img),
                fit: BoxFit.cover,
              ),
              // child: Image.asset(widget.product.prod_img),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              width: 160,
              child: Text(
                widget.product.name,
                // widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          // Container(
          //   width: 160,
          //   alignment: Alignment.centerRight,
          //   child:
          Text(
            "RM ${widget.product.price.toStringAsFixed(2)}",
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
                color: buttonColor),
          ),

          // ),
        ],
      ),
    );
  }

// Future getData() async{
//   Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Charset': 'utf-8'
//   };
//
//   var url = Uri.parse('https://remdii-lipidware.000webhostapp.com/read_products_data.php');
//   http.Response response = await http.get(url, headers: headers);
//   prod_data =jsonDecode(jsonEncode(response.body));
//   print(prod_data.toString());
//
//   // String jsonsDataString = response.body.toString(); // toString of Response's body is assigned to jsonDataString
//   // _data = jsonDecode(jsonsDataString);
//   // print(_data.toString());
// }

}
