import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/MyCart/order_completed_screen.dart';
import 'package:fyp/Screens/MyCart/order_failed_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:gkash_flutter_sdk/gkash_flutter_sdk.dart';
import 'package:gkash_flutter_sdk/gkash_payment_callback.dart';
import 'package:gkash_flutter_sdk/payment_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutConfirmation extends StatefulWidget {
  const CheckoutConfirmation({super.key, required this.total});
  final double total;

  @override
  State<CheckoutConfirmation> createState() => _CheckoutConfirmationState();
}

class _CheckoutConfirmationState extends State<CheckoutConfirmation>
    implements GkashPaymentCallback {
  //implements PaymentCallback {
  String buyerName = "";
  String buyerPhoneNo = "";
  String buyeraddress1 = "";
  String buyeraddress2 = "";
  String buyeraddress3 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.total);
    getPreferencesOrder();
  }

  getPreferencesOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      buyerName = prefs.getString("rName").toString();
      buyerPhoneNo = prefs.getString("rPhone").toString();
      buyeraddress1 = prefs.getString("rAdd1").toString();
      buyeraddress2 = prefs.getString("rAdd2").toString();
      buyeraddress3 = prefs.getString("rAdd3").toString();
    });
    print(buyerName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Confirmation",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          height: 450,
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9).withOpacity(1.0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              //fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      buyerName,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone No.",
                          style: TextStyle(
                              //fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      buyerPhoneNo,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                              //fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      buyeraddress1,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                    Text(
                      buyeraddress2,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                    Text(
                      buyeraddress3,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total (RM)",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0),
                    ),
                    Text(
                      '${widget.total.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedButton(
                    text: "Pay Now",
                    press: () async {
                      requestPayment2();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  requestPayment2() {
    //Generate your Payment Request
    PaymentRequest request = PaymentRequest(
      version: '1.5.5',
      //cid: "M161-U-40588", //Your merchant Id
      cid: "M102-U-52297",
      //cid: "M161-U-33",
      currency: 'MYR',
      amount: widget.total.toString(), // 1.00
      cartid: DateTime.now().millisecondsSinceEpoch.toString(), //Unique cart Id
      //signatureKey: "JrgDJp7O4cz14Yu", //Your signature key
      signatureKey: "cZW27Ta2xsPMIgA",
      //signatureKey: "oAhVwtUxfrop4cI",
      billingStreet: buyeraddress1 + " " + buyeraddress2 + " " + buyeraddress3,
      mobileNo: buyerPhoneNo,
      firstName: buyerName,
      
    );

    try {
      // Get instance of GkashPayment
      GkashFlutterSdk? _gkashFlutterSdk = GkashFlutterSdk.getInstance();
      // Set environment and start payment
      _gkashFlutterSdk!.setProductionEnvironment(true);
      _gkashFlutterSdk.startPayment(context, request, this);
    } catch (e) {
      //catch exception when sdk throw exception
      print(e);
    }
  }

  @override
  void onPaymentResult(
      String? status,
      String? description,
      String? companyRemId,
      String? poId,
      String? cartId,
      String? amount,
      String? currency,
      String? paymentType) {
    print('Gkash Payment Demo: Payment done.');

    // handle payment response
    if (status == "88 - Transferred") {
      print("Transferred");
      Future.delayed(Duration(milliseconds: 400), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OrderCompletedScreen();
            },
          ),
        );
      });

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => HomepageScreen(),
      //   ),
      //   (route) => false,
      // );
    } else if (status == "66 - Failed") {
      print("Failed");
      Future.delayed(Duration(milliseconds: 400), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OrderFailedScreen();
            },
          ),
        );
      });
    } else if (status == "11 - Pending") {
      print("Pending");
    }
  }

  // requestPayment() {
  //   PaymentRequest request = PaymentRequest(
  //     version: '1.5.0',
  //     cid: "M161-U-33",
  //     currency: 'MYR',
  //     amount: widget.total.toString(),
  //     cartid: DateTime.now().millisecondsSinceEpoch.toString(),
  //     signatureKey: "oAhVwtUxfrop4cI",
  //     isProd: true,
  //     paymentCallback: this,
  //   );

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return GkashWebView(request);
  //       },
  //     ),
  //   );
  // }

  // @override
  // void getPaymentStatus(PaymentResponse response) {
  //   if (response.status == "88 - Transferred") {
  //     print("Transferred");
  //     Future.delayed(Duration(milliseconds: 400), () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return OrderCompletedScreen();
  //           },
  //         ),
  //       );
  //     });

  //     // Navigator.pushAndRemoveUntil(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (BuildContext context) => HomepageScreen(),
  //     //   ),
  //     //   (route) => false,
  //     // );
  //   } else if (response.status == "66 - Failed") {
  //     print("Failed");
  //     Future.delayed(Duration(milliseconds: 400), () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return OrderFailedScreen();
  //           },
  //         ),
  //       );
  //     });
  //   } else if (response.status == "11 - Pending") {
  //     print("Pending");
  //   }
  // }
}
