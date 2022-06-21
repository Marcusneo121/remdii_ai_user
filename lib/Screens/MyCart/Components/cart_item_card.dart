import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:fyp/DB_Models/Cart.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key? key, required this.cart, required this.totalStream, required this.numItemStream,
  }) : super(key: key);

  final Cart cart;
  final StreamController totalStream;
  final StreamController numItemStream;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  @override
  Widget build(BuildContext context) {
    int aaa = widget.cart.qty;
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: AspectRatio(
            aspectRatio: 0.85,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.memory(base64.decode(widget.cart.product.prod_img)),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text.rich(
                TextSpan(
                  text:
                  "RM ${widget.cart.product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                      color: buttonColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 130,
                    child: SpinBox(
                      readOnly: true,
                      min: 1,
                      value: double.parse(aaa.toString()),
                      max: 10,
                      onChanged: (value) async {
                        var num = (value - aaa).toInt();
                        widget.totalStream.sink.add(num * widget.cart.product.price);

                        aaa = value.toInt();
                        var conn = await MySqlConnection.connect(settings);
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                        await conn.query('update cart SET qty = ? WHERE user_id = ? AND prod_id = ?',[value, prefs.getInt('userID'), widget.cart.product.prod_id]);

                      },

                    ),
                  ),
              //     IconButton(
              //       icon:Icon(Icons.horizontal_rule, color: buttonColor,),
              //       onPressed: (){},
              //     ),
              //     Container(
              //       //margin: const EdgeInsets.symmetric(horizontal: 10),
              //       // padding: const EdgeInsets.all(10),
              //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //       decoration: BoxDecoration(
              //         border: Border.all(color: hintColor.withOpacity(0.4)),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Text(
              //         "${cart.numOfItems}",
              //         style: TextStyle(
              //           fontFamily: 'Lato',
              //           fontWeight: FontWeight.w800,
              //           fontSize: 14.0,
              //           color: buttonColor,
              //         ),
              //       ),
              //     ),
              //     IconButton(
              //       icon: Icon(Icons.add, color: buttonColor,),
              //       onPressed: (){},
              //     ),
                ],
              ),
            ],

          ),
        )
      ],
    );
  }
}