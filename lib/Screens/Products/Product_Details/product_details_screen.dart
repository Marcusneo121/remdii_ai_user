import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:fyp/DB_Models/Products.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'Widgets/expandable.dart';

class PDetailsScreen extends StatelessWidget {
  final Product product;

  const PDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter;
    getCounter() {
      return counter;
    }

    setCounter(var value) {
      counter = value;
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Products",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Header(product: product),
              AspectRatio(
                aspectRatio: 1.8,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12.withAlpha(10),
                    ),
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.memory(
                                    base64.decode(product.prod_img),
                                    // Image.asset(product.prod_img,
                                    // width: constraints.maxWidth * 0.65,
                                    // height: constraints.maxHeight * 0.9,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      // product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      product.stock,
                      // product.stock,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                        color: buttonColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "RM ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                            fontSize: 17.0,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: SpinBox(
                            value: 1,
                            readOnly: true,
                            min: 1,
                            max: 10,
                            onChanged: (value) => (setCounter(value)),
                          ),
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.horizontal_rule,
                        //     color: buttonColor,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // Container(
                        //   // margin: const EdgeInsets.symmetric(horizontal: 5),
                        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: hintColor.withOpacity(0.4)),
                        //     borderRadius: BorderRadius.circular(12),
                        //   ),
                        //   child: Text(
                        //     "1",
                        //     style: TextStyle(
                        //       fontFamily: 'Lato',
                        //       fontWeight: FontWeight.w800,
                        //       fontSize: 14.0,
                        //       color: buttonColor,
                        //     ),
                        //   ),
                        // ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.add,
                        //     color: buttonColor,
                        //   ),
                        //   onPressed: () {},
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              // Details(product: product),
              Divider(
                color: kPrimaryColor,
              ),
              Expandable(
                product: product,
                title: "Description",
                desc: product.prod_desc,
                // desc: product.prod_desc,
              ),
              Divider(
                color: kPrimaryColor,
                indent: 15,
                endIndent: 15,
              ),
              Expandable(
                product: product,
                title: "Additional Information",
                desc: product.add_info,
                // desc: product.add_info,
              ),
              SizedBox(
                height: 20.0,
              ),
              // _buildSectionTitle('Related Products'),
              // RelatedProducts(),
              RoundedButton(
                text: "Add to Cart",
                press: product.stock == 'Out of Stock'? (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text(
                            'The item is out of stock.'),
                        actions: <Widget>[
                          FlatButton(
                            child: new Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var settings = new ConnectionSettings(
                    host: connection.host,
                    port: connection.port,
                    user: connection.user,
                    password: connection.pw,
                    db: connection.db,
                  );
                  var conn = await MySqlConnection.connect(settings);
                  print(getCounter());
                  var counterValue = getCounter();
                  if (getCounter() == null) counterValue = 1;
                  var result = await conn.query(
                      'SELECT * FROM cart '
                      'WHERE user_id = ? AND prod_id = ?',
                      [prefs.getInt('userID'), product.prod_id]);

                  if (result.isEmpty) {
                    await conn.query(
                        'INSERT INTO cart'
                        '(user_id, prod_id, qty) VALUE (?, ?, ?)',
                        [
                          prefs.getInt('userID'),
                          product.prod_id,
                          counterValue
                        ]);
                    final snackBar = SnackBar(
                      content: const Text('Added to cart successfully!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    var qty;
                    for (var row in result) {
                      qty = row[2];
                    }
                    counterValue += qty;
                    if (counterValue <= 10) {
                      await conn.query(
                          'UPDATE cart SET qty=? WHERE user_id=? AND prod_id = ?',
                          [
                            counterValue,
                            prefs.getInt('userID'),
                            product.prod_id
                          ]);
                      final snackBar = SnackBar(
                        content: const Text('Added to cart successfully!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text(
                                'You have reached the maximum number of purchase limit.'),
                            actions: <Widget>[
                              FlatButton(
                                child: new Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  await conn.close();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
            ),
          )
        ],
      ),
    );
  }
}
