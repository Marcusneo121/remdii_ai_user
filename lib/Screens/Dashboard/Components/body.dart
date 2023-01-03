import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Chat/chat_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/view_and_update_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/view_orders_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/Edit%20Personal%20Details/view_personal_details_screen.dart';
import 'package:fyp/Screens/Dashboard/Questionnaire/tracker.dart';
import 'package:fyp/Screens/EczemaDiagnosis/eczema_diagnosis_screen.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen_after_ai_result.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen_with_back.dart';
import 'package:fyp/Screens/Homepage/my_drawer_header.dart';
import 'package:fyp/Screens/MyCart/my_cart_screen.dart';
import 'package:fyp/Screens/Products/products.dart';
import 'package:fyp/Screens/Welcome/welcome_screen.dart';
import 'package:fyp/components/nav_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyHeaderDrawer(),
            SizedBox(height: size.height * 0.02),
            nav_button(
              text: "Eczema Management",
              icon: Icons.medical_services_outlined,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EDiagnosisScreen();
                    },
                  ),
                );
              },
            ),
            nav_button(
              text: "View and Update",
              icon: FontAwesomeIcons.calendarAlt,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ViewUpdate();
                    },
                  ),
                );
              },
            ),
            // nav_button(
            //   text: "Eczema Info Centre",
            //   icon: Icons.info_outline,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           //Can use EInfoScreen, but need to add AppBar for back button
            //           return ViewInfoScreenWithBack();
            //         },
            //       ),
            //     );
            //   },
            // ),
            nav_button(
              text: "Our Product",
              icon: FontAwesomeIcons.shoppingBasket,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductScreen();
                    },
                  ),
                );
              },
            ),
            nav_button(
              text: "Chat with Us",
              icon: FontAwesomeIcons.commentDots,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatDetailPage();
                    },
                  ),
                );
              },
            ),
            nav_button(
              text: "Eczema Tracker",
              icon: FontAwesomeIcons.chartSimple,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TrackerScreen();
                    },
                  ),
                );
              },
            ),
            // nav_button(
            //   text: "View Orders",
            //   icon: FontAwesomeIcons.dollyFlatbed,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return ViewOrders();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // nav_button(
            //   text: "My Cart",
            //   icon: Icons.shopping_cart,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return MyCartScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // nav_button(
            //   text: "Settings",
            //   icon: FontAwesomeIcons.solidUserCircle,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return ViewPersonalDetails();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // nav_button(
            //   text: "Log Out",
            //   icon: FontAwesomeIcons.signOutAlt,
            //   press: () async {
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     await prefs.remove('userID');
            //     print(prefs.getInt('userID'));
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => WelcomeScreen(),
            //       ),
            //       (route) => false,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
