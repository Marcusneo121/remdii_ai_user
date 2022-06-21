import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Cart.dart';
import 'package:fyp/Screens/MyCart/Components/body.dart';
import 'package:fyp/Screens/MyCart/shipment_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCartScreen extends StatefulWidget {
  //const MyCartScreen({Key? key}) : super(key: key);
  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final totalStream = StreamController<double>();
  final cartStream = StreamController();
  final numItemStream = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("My Cart Page"),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   foregroundColor: hintColor,
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      // ),
      body: Body(totalStream: totalStream, cartStream: cartStream, numItemStream: numItemStream,),
      bottomNavigationBar: CheckCartDetails(totalStream: totalStream, cartStream: cartStream, numItemStream: numItemStream,),
    );
  }
}

class CheckCartDetails extends StatefulWidget {
  final StreamController cartStream;
  final StreamController numItemStream;

  CheckCartDetails({
    Key? key, required this.totalStream, required this.cartStream, required this.numItemStream,
  }) : super(key: key);
  final StreamController<double> totalStream;

  @override
  State<CheckCartDetails> createState() => _CheckCartDetailsState();
}

class _CheckCartDetailsState extends State<CheckCartDetails> {
  double total = 0;
  int numItem = 0;
  getTotal(var result){
    numItem = result.length + 1;
    for (Cart row in result){
      total = total + row.product.price * row.qty;
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: widget.cartStream.stream,
      initialData: [],
      builder: (context, AsyncSnapshot snapshot) {
        getTotal(snapshot.data);
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          height: 146,
          decoration: BoxDecoration(
              color: Color(0xFFF5F6F9).withOpacity(0.9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -4),
                  blurRadius: 20,
                  color: Color(0xFFDADADA).withOpacity(0.8),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                        stream: widget.numItemStream.stream,
                        initialData: 0,
                        builder: (context, AsyncSnapshot snapshot2) {
                          numItem-=1;
                          return Text.rich(
                            TextSpan(
                              text: "${numItem} item(s)",
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          );
                        }
                    ),
                    StreamBuilder<double>(
                        stream: widget.totalStream.stream,
                        initialData: 0.00,
                        builder: (context, AsyncSnapshot snapshot1) {
                          total = total + snapshot1.data;
                          return Text.rich(
                            TextSpan(
                              text: "Total: RM " + total.toStringAsFixed(2),
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          );
                        }
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     SizedBox(
                //       width: 150,
                //       height: 69,
                //       child:
                //     ),
                //   ],
                // )
                Container(
                  // width: 150,
                  child: RoundedButton(
                    text: "Checkout",
                    press: () async {
                      var settings = new ConnectionSettings(
                          host: connection.host,
                          port: connection.port,
                          user: connection.user,
                          password: connection.pw,
                          db: connection.db);
                      var conn = await MySqlConnection.connect(settings);
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      var result = await conn.query('SELECT qty FROM cart WHERE user_id = ?',[prefs.getInt('userID')]);
                      if(result.length == 0){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text(
                                  'Your Cart is Empty!'),
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
                      }else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ShipmentScreen(subtotal: total,);
                            },
                          ),
                        );
                      }
                      await conn.close();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
