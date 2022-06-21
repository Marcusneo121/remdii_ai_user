import 'package:flutter/material.dart';
import 'package:fyp/Screens/MyCart/Components/expandable.dart';
import 'package:fyp/components/rounded_button.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({Key? key}) : super(key: key);

  @override
  _OrderInfoScreenState createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment Info",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
