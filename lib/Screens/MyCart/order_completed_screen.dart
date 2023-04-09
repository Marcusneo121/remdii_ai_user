import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/MyCart/payment_info_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class OrderCompletedScreen extends StatefulWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

  @override
  _OrderCompletedScreenState createState() => _OrderCompletedScreenState();
}

class _OrderCompletedScreenState extends State<OrderCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
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
      body: Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/completed.png"),
                Image.asset("assets/images/OrderCompleted2.png"),
                SizedBox(height: 5),
                RoundedButton(
                    text: "Back to Home",
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

                      var results = await conn.query(
                          'SELECT qty, price, cart.prod_id FROM cart, products '
                          'WHERE cart.prod_id = products.prod_id AND '
                          'user_id = ?',
                          [prefs.getInt('userID')]);
                      double total = 0.00;
                      for (var row in results) {
                        print(row[0].toString() + ' ' + row[1].toString());
                        total = total + (row[0] * row[1]);
                        print(total);
                      }
                      var now = new DateTime.now();
                      var date = new DateFormat('dd/MM/yyyy');
                      String formattedDate = date.format(now);
                      var time = new DateFormat.jm();
                      String formattedTime = time.format(now);
                      await conn.query(
                          'INSERT INTO orderhistory (orderDate, orderTime, orderAmt, shippingFee,'
                          'trackingNo, status, user_id, shippedDate, shippedTime, courier_company) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                          [
                            formattedDate,
                            formattedTime,
                            total,
                            6,
                            '-',
                            'Paid', //this was Unpaid, after payment gateway integrated, so need Paid
                            prefs.getInt('userID'),
                            '-',
                            '-',
                            '-',
                          ]);
                      //print('OH');
                      var orderHistory =
                          await conn.query('SELECT orderID FROM orderhistory');
                      //print('SOH');
                      int lastID = 0;
                      for (var row in orderHistory) {
                        if (lastID < row[0]) lastID = row[0];
                      }
                      print(lastID);
                      for (var row in results) {
                        print(row[0].toString() + ' ' + row[1].toString());
                        // total = total + (row[0] * row[1]);
                        // print(total);
                        await conn.query(
                            'INSERT INTO orderdetails (orderID, prodID, qty, totalPrice) VALUES '
                            '(?, ?, ?, ?)',
                            [lastID, row[2], row[0], row[1] * row[0]]);
                        print('OD');
                      }
                      await conn.query(
                          'INSERT INTO deliveryrecipient (recipientName, recipientPhone, recipientAdd1, recipientAdd2, recipientAdd3, orderID) VALUES '
                          '(?, ?, ?, ?, ?, ?)',
                          [
                            prefs.getString('rName'),
                            prefs.getString('rPhone'),
                            prefs.getString('rAdd1'),
                            prefs.getString('rAdd2'),
                            prefs.getString('rAdd3'),
                            lastID
                          ]);
                      await conn.query('DELETE FROM cart WHERE user_id = ?',
                          [prefs.getInt('userID')]);
                      prefs.remove('rName');
                      prefs.remove('rPhone');
                      prefs.remove('rAdd1');
                      prefs.remove('rAdd2');
                      prefs.remove('rAdd3');

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomepageScreen(),
                        ),
                        (route) => false,
                      );
                      await conn.close();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
