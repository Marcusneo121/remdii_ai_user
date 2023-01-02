import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/MyCart/order_completed_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:lottie/lottie.dart';

class OrderFailedScreen extends StatefulWidget {
  const OrderFailedScreen({
    super.key,
  });

  @override
  State<OrderFailedScreen> createState() => _OrderFailedScreenState();
}

class _OrderFailedScreenState extends State<OrderFailedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: const Text("Payment"),
      // ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/images/failed.json',
                  width: 300,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Payment Failed. Something went wrong',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0),
                ),
                Text(
                  'Please try again.',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'or Try other payment method.',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0),
                ),
                SizedBox(
                  height: 40,
                ),
                Spacer(),
                RoundedButton(
                  text: "Try again",
                  press: () async {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Text('Back to Order Confirmation'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
