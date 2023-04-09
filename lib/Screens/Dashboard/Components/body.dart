import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:fyp/Screens/Tracker/tracker_main_screen.dart';
import 'package:fyp/Screens/Welcome/welcome_screen.dart';
import 'package:fyp/components/nav_button.dart';
import 'package:fyp/constants.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/DB_Models/connection.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  currentDayMonthYearGetter() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    final dateTimeSplitter = formattedDate.split('-');
    print(dateTimeSplitter[0]);
    print(dateTimeSplitter[1]);
    print(dateTimeSplitter[2]);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (int.parse(dateTimeSplitter[2]) <= 7) {
      prefs.setString('currentWeekDashboard', '1');
    } else if (int.parse(dateTimeSplitter[2]) > 7 &&
        int.parse(dateTimeSplitter[2]) <= 14) {
      prefs.setString('currentWeekDashboard', '2');
    } else if (int.parse(dateTimeSplitter[2]) > 14 &&
        int.parse(dateTimeSplitter[2]) <= 21) {
      prefs.setString('currentWeekDashboard', '3');
    } else if (int.parse(dateTimeSplitter[2]) > 21) {
      prefs.setString('currentWeekDashboard', '4');
    }

    prefs.setString('currentDayDashboard', dateTimeSplitter[2]);
    prefs.setString('currentMonthDashboard', dateTimeSplitter[1]);
    prefs.setString('currentYearDashboard', dateTimeSplitter[0]);

    print(prefs.getString('currentWeekDashboard'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDayMonthYearGetter();
  }

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
            // nav_button(
            //   text: "Eczema Management",
            //   icon: Icons.medical_services_outlined,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) {
            //           return EDiagnosisScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // nav_button(
            //   text: "View and Update",
            //   icon: FontAwesomeIcons.calendarAlt,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return ViewUpdate();
            //         },
            //       ),
            //     );
            //   },
            // ),
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
            // nav_button(
            //   text: "Eczema Tracker",
            //   icon: FontAwesomeIcons.chartSimple,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) {
            //           return TrackerScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            nav_button(
              text: "Eczema Tracker",
              icon: FontAwesomeIcons.chartSimple,
              press: () async {
                var conn = await MySqlConnection.connect(settings);
                SharedPreferences prefs = await SharedPreferences.getInstance();

                print(prefs.getString('currentYearDashboard').toString());
                print(prefs.getString('currentMonthDashboard').toString());
                print(prefs.getString('currentWeekDashboard').toString());
                var checkResults = await conn.query(
                    'SELECT * FROM lineChart WHERE user_id = ? AND year = ? AND month = ? AND week = ? ORDER BY week ASC',
                    [
                      prefs.getInt('userID'),
                      prefs.getString('currentYearDashboard'),
                      prefs.getString('currentMonthDashboard'),
                      prefs.getString('currentWeekDashboard'),
                    ]);

                if (checkResults.isEmpty) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return EDiagnosisScreen();
                      },
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text(
                          'You had already submitted this week data. Press OK to continue, if you wish to overwrite it.',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: new Text("OK"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    return EDiagnosisScreen();
                                  },
                                ),
                              );
                            },
                          ),
                          ElevatedButton(
                            child: new Text("Cancel"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.6)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            nav_button(
              text: "Tracker Result",
              icon: FontAwesomeIcons.codePullRequest,
              press: () {
                // String a = "admin1";
                // String b = "anshzwna";
                // if (a.substring(0, 1).codeUnitAt(0) >
                //     b.substring(0, 1).codeUnitAt(0)) {
                //   print("$b\_$a");
                // } else {
                //   print("$a\_$b");
                // }

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return TrackerMainScreen();
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
