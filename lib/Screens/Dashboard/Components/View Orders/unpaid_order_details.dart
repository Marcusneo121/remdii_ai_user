import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/DB_Models/Order.dart';
import 'package:fyp/DB_Models/User.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/unpaid_order_item_card.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';

class UnpaidOrderDetails extends StatefulWidget {
  const UnpaidOrderDetails({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  _UnpaidOrderDetailsState createState() => _UnpaidOrderDetailsState();
}

class _UnpaidOrderDetailsState extends State<UnpaidOrderDetails> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;
  ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? payment_img;

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
            user_img: row[5].toString()));
      }
      print('Check order ID');
      print(widget.order.orderID);
      await conn.close();
      return recipientDetails;
    } catch (e) {
      print(e);
    }
  }

  void selectImages() async {
    String? imagenConvertida;
    imagenConvertida = "";

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image!.length() != 0) {
      _image = XFile(image.path);
      var bytes = _image!.readAsBytes();
      imagenConvertida = base64.encode(await bytes);
      print(imagenConvertida);
      payment_img = imagenConvertida;
    }

    setState(() {});
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        selectImages();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
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
                            child: UnpaidOrderItemCard(
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
                        Text(
                          "Please upload your payment receipt here. ",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                        Divider(
                          color: hintColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Center(
                            child: _image != null
                                ? Container(
                                    width: size.width * 1.0,
                                    height: size.height * 0.8,
                                    child: Image.file(
                                      File(_image!.path),
                                      // width: size.width * 1.0,
                                      // height: size.height * 0.8,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                    ),
                                    width: size.width * 1.0,
                                    height: size.height * 0.8,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                      size: 50,
                                    ),
                                  ),
                          ),
                        ),
                        RoundedButton(
                            text: 'Submit',
                            press: () async {
                              if (_image != null) {
                                var conn =
                                    await MySqlConnection.connect(settings);
                                await conn.query(
                                    'UPDATE orderhistory SET'
                                    ' status = "Paid", paymentImg = ? '
                                    'WHERE orderID = ?',
                                    [
                                      payment_img,
                                      widget.order.orderID,
                                    ]);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text(
                                          'Your payment receipt has been uploaded for verification purpose. Your order will be placed once the payment has been verified by our staff.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: new Text("Back to Home"),
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        HomepageScreen(),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: new Text(
                                          'Please upload your payment receipt for verification purpose to place your order.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: new Text("OK"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            })
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
