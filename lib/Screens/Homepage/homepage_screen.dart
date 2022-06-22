import 'package:flutter/material.dart';
import 'package:fyp/Screens/Dashboard/Components/Edit%20Personal%20Details/edit_personal_details_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/view_orders_screen.dart';
import 'package:fyp/Screens/Dashboard/dashboard_screen.dart';
import 'package:fyp/Screens/EczemaDiagnosis/eczema_diagnosis_screen.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen.dart';
import 'package:fyp/Screens/EczemaInfo/view_info_screen.dart';
import 'package:fyp/Screens/Homepage/my_drawer_header.dart';
import 'package:fyp/Screens/MyCart/my_cart_screen.dart';
import 'package:fyp/Screens/Products/products.dart';
import 'package:fyp/Screens/Welcome/welcome_screen.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:fyp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  //const Homepage({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //var currentPage = DrawerSections.dashboard;
  var currentPage = DrawerSections.dashboard;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardScreen();
    } else if (currentPage == DrawerSections.my_cart) {
      container = MyCartScreen();
    } else if (currentPage == DrawerSections.view_order) {
      container = ViewOrders();
    } else if (currentPage == DrawerSections.eczema_info) {
      container = EInfoScreen();
    } else if (currentPage == DrawerSections.setting) {
      container = EditPersonalDetails();
    }

    return Container(
      height: size.height,
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: container,
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  myDrawerList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        // show the list of menu drawer
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "My Cart", Icons.shopping_cart,
              currentPage == DrawerSections.my_cart ? true : false),
          menuItem(3, "View Order", Icons.shopping_basket,
              currentPage == DrawerSections.view_order ? true : false),
          menuItem(4, "Eczema Info Centre", FontAwesomeIcons.info,
              currentPage == DrawerSections.eczema_info ? true : false),
          menuItem(5, "Setting", Icons.settings_rounded,
              currentPage == DrawerSections.setting ? true : false),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('userID');
              print(prefs.getInt('userID'));
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => WelcomeScreen(),
                ),
                (route) => false,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(
                      FontAwesomeIcons.signOutAlt,
                      size: 25,
                      color: hintColor,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[200] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.my_cart;
            } else if (id == 3) {
              currentPage = DrawerSections.view_order;
            } else if (id == 4) {
              currentPage = DrawerSections.eczema_info;
            } else if (id == 5) {
              currentPage = DrawerSections.setting;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 25,
                  color: hintColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  my_cart,
  view_order,
  eczema_info,
  setting,
}
