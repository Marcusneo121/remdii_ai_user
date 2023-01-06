import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/DB_Models/User.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/MyCart/checkout_confirmation.dart';
import 'package:fyp/Screens/MyCart/payment_info_screen.dart';
import 'package:fyp/Screens/MyCart/payment_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({Key? key, required this.subtotal}) : super(key: key);
  final double subtotal;

  @override
  _ShipmentScreenState createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final add1Controller = TextEditingController();
  final add2Controller = TextEditingController();
  final add3Controller = TextEditingController();
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;
  late double subValue;

  void initState() {
    // TODO: implement initState
    _future = fetchUserData();
    subValue = widget.subtotal;
    print(subValue.toString());
    super.initState();
  }

  fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<User> user = [];
      var conn = await MySqlConnection.connect(settings);
      print(prefs.getInt('userID'));

      if (prefs.getInt('userID') != null) {
        var results = await conn.query(
            'SELECT * FROM customer WHERE user_id = ?',
            [prefs.getInt('userID').toString()]);
        //print(results);
        for (var row in results) {
          user.add(User(
            user_name: row[1].toString(),
            user_email: row[2].toString(),
            user_id: row[0],
            user_phone: row[4].toString(),
            user_ic: row[5].toString(),
            user_add_1: row[6].toString(),
            user_add_2: row[7].toString(),
            user_add_3: row[8],
            user_img: row[9].toString(),
          ));

          setState(() {
            nameController.text = row[1].toString();
            phoneController.text = row[4].toString();
            add1Controller.text = row[6].toString();
            add2Controller.text = row[7].toString();
            add3Controller.text = row[8].toString();
          });
        }
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double shippingFee = 6.00;
    // double subTotal = double.parse(subValue);

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomepageScreen();
              },
            ),
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Checkout",
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 22.0),
            ),
            actions: [
              IconButton(
                  icon: Icon(FontAwesomeIcons.infoCircle),
                  color: hintColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PaymentInfoScreen();
                        },
                      ),
                    );
                  })
            ],
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
                        child: Container(
                          child: Form(
                            key: formGlobalKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/shipping.png"),
                                SizedBox(
                                  height: 20.0,
                                ),
                                RoundedInputField(
                                  //initialValue: snapshot.data[0].user_name,
                                  icon: Icons.person,
                                  onChanged: (value) {},
                                  validator: validateName,
                                  hintText: 'Full Name',
                                  enableMode: true,
                                  controller: nameController,
                                ),
                                RoundedInputField(
                                  //initialValue: snapshot.data[0].user_phone,
                                  icon: Icons.local_phone,
                                  onChanged: (value) {},
                                  validator: validatePhone,
                                  hintText: 'Phone Number',
                                  enableMode: true,
                                  controller: phoneController,
                                ),
                                RoundedInputField(
                                  //initialValue: snapshot.data[0].user_add_1,
                                  icon: Icons.location_on,
                                  onChanged: (value) {},
                                  validator: validateAddress,
                                  hintText: 'Address Line 1',
                                  enableMode: true,
                                  controller: add1Controller,
                                ),
                                RoundedInputField(
                                  //initialValue: snapshot.data[0].user_add_2,
                                  icon: Icons.location_on,
                                  onChanged: (value) {},
                                  validator: validateAddress,
                                  hintText: 'Address Line 2',
                                  enableMode: true,
                                  controller: add2Controller,
                                ),
                                RoundedInputField(
                                  //initialValue: snapshot.data[0].user_add_3,
                                  icon: Icons.location_on,
                                  onChanged: (value) {},
                                  validator: validateAddress,
                                  hintText: 'Address Line 3',
                                  enableMode: true,
                                  controller: add3Controller,
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9).withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Subtotal (RM)",
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0),
                                            ),
                                            Text(
                                              '${subValue.toStringAsFixed(2)}',
                                              // getSubTotal(),
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery Charges (RM)",
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0),
                                            ),
                                            Text(
                                              shippingFee.toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total (RM)",
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20.0),
                                            ),
                                            Text(
                                              '${(subValue + shippingFee).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                RoundedButton(
                                    text: "Continue",
                                    press: () async {
                                      if (formGlobalKey.currentState!
                                          .validate()) {
                                        formGlobalKey.currentState!.save();
                                        var conn =
                                            await MySqlConnection.connect(
                                                settings);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            'rName', nameController.text);
                                        prefs.setString(
                                            'rPhone', phoneController.text);
                                        prefs.setString(
                                            'rAdd1', add1Controller.text);
                                        prefs.setString(
                                            'rAdd2', add2Controller.text);
                                        prefs.setString(
                                            'rAdd3', add3Controller.text);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return PaymentScreen();
                                        //     },
                                        //   ),
                                        // );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return CheckoutConfirmation(
                                                total: subValue + shippingFee,
                                              );
                                            },
                                          ),
                                        );
                                        await conn.close();
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(child: Text('Network error'));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }

  String? validateName(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your name is required";
      return _msg;
    }
    return null;
  }

  String? validatePhone(String? value) {
    String _msg = '';
    RegExp regex = new RegExp(r'(^01[0-9]{8,9}$)');
    if (value!.isEmpty) {
      _msg = "Your phone number is required";
      return _msg;
    } else if (!regex.hasMatch(value)) {
      _msg =
          "Please provide a valid phone number with \nthe given format (0123456789)";
      // phoneController.text = '';
      return _msg;
    }
    return null;
  }

  String? validateAddress(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your address is required";
      return _msg;
    }
    return null;
  }

  // getTotal() {
  //   final double shippingFee = 6.00;
  //   double totalAmt = 0.00;
  //   totalAmt = widget.subtotal + shippingFee;
  //
  //   return totalAmt.toStringAsFixed(2);
  // }
  //
  // getSubTotal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double subtotal;
  //   subtotal = prefs.getDouble('subtotal')!;
  //   return subtotal.toStringAsFixed(2);
  // }
}
