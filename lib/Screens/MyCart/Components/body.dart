import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/DB_Models/Cart.dart';
import 'package:fyp/DB_Models/Products.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/MyCart/Components/cart_item_card.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.totalStream,
      required this.cartStream,
      required this.numItemStream})
      : super(key: key);
  final StreamController totalStream;
  final StreamController cartStream;
  final StreamController numItemStream;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;
  int numItem = 0;

  @override
  void initState() {
    _future = fetchCartData();
    super.initState();
  }

  fetchCartData() async {
    try {
      List<Cart> cartList = [];
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var results = await conn.query(
          'SELECT prod_img, name, prod_desc, add_info, stock, products.prod_id, series_id, price, qty'
          ' FROM cart, customer, products '
          'WHERE cart.user_id = customer.user_id AND cart.prod_id = products.prod_id AND cart.user_id = ?;',
          [prefs.getInt('userID')]);

      print(results);
      //print('connected database');

      for (var row in results) {
        cartList.add(Cart(
            product: Product(
                prod_img: row[0].toString(),
                name: row[1],
                prod_desc: row[2].toString(),
                add_info: row[3].toString(),
                stock: row[4],
                prod_id: row[5],
                series_id: row[6],
                price: row[7]),
            qty: row[8]));
      }
      print(cartList.length);
      numItem = cartList.length;
      widget.cartStream.sink.add(cartList);
      await conn.close();
      return cartList;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("aa");
            if (numItem > 0) {
              print("a");
              return Container(
                width: double.infinity,
                height: size.height,
                padding: EdgeInsets.all(20.0),
                child: Column(
                    // padding: EdgeInsets.symmetric(horizontal: 5),
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Cart",
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22.0),
                            ),
                            InkWell(
                              child: Text(
                                "Back to Home",
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF42995C),
                                    fontSize: 15.0),
                              ),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Homepage();
                                    },
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Dismissible(
                              key: Key(snapshot.data[index].product.prod_id
                                  .toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFE6E6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      FontAwesomeIcons.trashAlt,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              onDismissed: (direction) async {
                                setState(() async {
                                  var conn =
                                      await MySqlConnection.connect(settings);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var result = await conn.query(
                                      'SELECT qty FROM cart WHERE user_id = ? AND prod_id = ?',
                                      [
                                        prefs.getInt('userID'),
                                        snapshot.data[index].product.prod_id
                                            .toString()
                                      ]);
                                  int qty = 0;
                                  for (var row in result) {
                                    qty = row[0] as int;
                                  }
                                  await conn.query(
                                      'DELETE FROM cart WHERE user_id = ? AND prod_id = ?',
                                      [
                                        prefs.getInt('userID'),
                                        snapshot.data[index].product.prod_id
                                            .toString()
                                      ]);
                                  numItem -= 1;
                                  widget.totalStream.sink.add(-qty *
                                      snapshot.data[index].product.price);
                                  widget.numItemStream.sink.add(-1);
                                  // snapshot.data.removeAt(index);
                                  //widget.cartStream.sink.add(snapshot.data);
                                  print(numItem.toString());
                                  await conn.close();
                                });
                              },
                              child: CartItemCard(
                                cart: snapshot.data[index],
                                totalStream: widget.totalStream,
                                numItemStream: widget.numItemStream,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              );
              print("b");
            }
            return Center(child: Text('Your Cart is Empty Now'));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
