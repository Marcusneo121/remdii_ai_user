import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/MyCart/Components/expandable.dart';
import 'package:fyp/Screens/MyCart/order_completed_screen.dart';
import 'package:fyp/Screens/MyCart/payment_info_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // final paymentData = [
  //   {
  //     "categoryId": 1,
  //     "categoryName": "Duit Now",
  //     "categoryImg": "assets/images/DuitNow.jpeg",
  //   },
  //   {
  //     "categoryId": 2,
  //     "categoryName": "MAE",
  //     "categoryImg": "assets/images/MAE.jpg",
  //   },
  //   {
  //     "categoryId": 3,
  //     "categoryName": "Touch N Go",
  //     "categoryImg": "assets/images/TouchNGo.jpg",
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                Image.asset("assets/images/payment.png"),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '- Please select one of the payment method and screenshot it to make your payment. \n- Please verify your payment by uploading your payment receipt to "View Orders" > "Unpaid" tab. ',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expandable(
                  title: "Touch N Go",
                  image: "assets/images/TNG_QR.png",
                ),
                Expandable(
                  title: "Duit Now",
                  image: "assets/images/DUIT_NOW_QR.png",
                ),
                Expandable(
                  title: "MAE",
                  image: "assets/images/MAE_QR.png",
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                    text: "Continue",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OrderCompletedScreen();
                          },
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
