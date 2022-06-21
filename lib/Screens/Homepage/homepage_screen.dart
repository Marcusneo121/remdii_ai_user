import 'package:flutter/material.dart';
import 'package:fyp/Screens/Dashboard/dashboard_screen.dart';
import 'package:fyp/Screens/EczemaDiagnosis/eczema_diagnosis_screen.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen.dart';
import 'package:fyp/Screens/EczemaInfo/view_info_screen.dart';
import 'package:fyp/Screens/Homepage/my_drawer_header.dart';
import 'package:fyp/Screens/MyCart/my_cart_screen.dart';
import 'package:fyp/Screens/Products/products.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:fyp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  var currentPage = DrawerSections.eczema_management;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardScreen();
    } else if (currentPage == DrawerSections.eczema_management) {
      container = EDiagnosisScreen();
    } else if (currentPage == DrawerSections.eczema_info) {
      container = EInfoScreen();
    } else if (currentPage == DrawerSections.products) {
      container = ProductScreen();
    } else if (currentPage == DrawerSections.my_cart) {
      container = MyCartScreen();
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
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Eczema Management", Icons.medical_services_outlined,
              currentPage == DrawerSections.eczema_management ? true : false),
          menuItem(3, "Eczema Info Centre", Icons.info_outline,
              currentPage == DrawerSections.eczema_info ? true : false),
          menuItem(4, "Products", FontAwesomeIcons.shoppingBasket,
              currentPage == DrawerSections.products ? true : false),
          menuItem(5, "My Cart", Icons.shopping_cart,
              currentPage == DrawerSections.my_cart ? true : false),
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
              currentPage = DrawerSections.eczema_management;
            } else if (id == 3) {
              currentPage = DrawerSections.eczema_info;
            } else if (id == 4) {
              currentPage = DrawerSections.products;
            } else if (id == 5) {
              currentPage = DrawerSections.my_cart;
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
  eczema_management,
  eczema_info,
  products,
  my_cart,
}
