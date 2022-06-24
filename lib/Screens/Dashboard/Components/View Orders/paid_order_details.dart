import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/DB_Models/Order.dart';
import 'package:fyp/DB_Models/User.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/paid_order_item_card.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/unpaid_order_item_card.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaidOrderDetails extends StatefulWidget {
  const PaidOrderDetails({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  _PaidOrderDetailsState createState() => _PaidOrderDetailsState();
}

class _PaidOrderDetailsState extends State<PaidOrderDetails> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    _future = fetchRecipientData();
    super.initState();
  }

  fetchRecipientData() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<User> recipientDetails = [];

      var results = await conn.query(
          'SELECT recipientName, recipientPhone, '
          'recipientAdd1, recipientAdd2, recipientAdd3 FROM orderhistory, deliveryrecipient '
          'WHERE deliveryrecipient.orderID = orderhistory.orderID '
          'AND orderhistory.orderID = ? AND orderhistory.user_id = ?',
          [widget.order.orderID, prefs.getInt('userID')]);

      for (var row in results) {
        recipientDetails.add(User(
            user_id: 0,
            user_name: row[0],
            user_email: '',
            user_phone: row[1],
            user_ic: '',
            user_add_1: row[2],
            user_add_2: row[3],
            user_add_3: row[4],
            user_img: row[9].toString()));
      }
      print('Check order ID');
      print(widget.order.orderID);
      await conn.close();
      return recipientDetails;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "View Orders",
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: 22.0),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Container(
                  height: size.height,
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                        Divider(
                          color: hintColor,
                        ),
                        ListView.builder(
                          itemCount: widget.order.orderDetails.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: PaidOrderItemCard(
                              orderDetails: widget.order.orderDetails[index],
                            ),
                          ),
                        ),
                        Divider(
                          color: hintColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Subtotal ",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              'RM ${widget.order.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Delivery Charges ",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              'RM ${widget.order.shippingFee.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total ",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              "RM ${(widget.order.amount + widget.order.shippingFee).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Order Details",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                        Divider(
                          color: hintColor,
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.solidUserCircle,
                                size: 35,
                                color: hintColor,
                              ),
                              title: Text(
                                'RECIPIENT DETAILS',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: Text(
                                '${snapshot.data[0].user_name} \n${snapshot.data[0].user_phone}',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                            SizedBox(height: 5.0),
                            ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                size: 35,
                                color: hintColor,
                              ),
                              title: Text(
                                'DELIVERY ADDRESS',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: Text(
                                '${snapshot.data[0].user_add_1} \n${snapshot.data[0].user_add_2} \n${snapshot.data[0].user_add_3}',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                            SizedBox(height: 5.0),
                            ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.solidClock,
                                size: 35,
                                color: hintColor,
                              ),
                              title: Text(
                                'ORDER DATE/TIME',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: Text(
                                '${widget.order.orderDate} \n${widget.order.orderTime}',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Payment Details",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                        Divider(
                          color: hintColor,
                        ),
                        Image.memory(base64.decode(widget.order.paymentImg)),
                        Text(
                          'Please wait for the admin to verify your payment. Declined payment will be sent back to "Unpaid" tabs and a new payment receipt should be uploaded again to complete your order.',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(child: Text('Network error'));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
