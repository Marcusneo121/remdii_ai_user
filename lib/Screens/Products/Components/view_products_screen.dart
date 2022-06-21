import 'package:flutter/material.dart';
import 'package:fyp/Screens/Products/Series/series_1_tab.dart';
import 'package:fyp/Screens/Products/Series/series_2_tab.dart';
import 'package:fyp/Screens/Products/Series/series_3_tab.dart';
import 'package:fyp/Screens/Products/Series/series_4_tab.dart';
import 'package:fyp/Screens/Products/Series/series_5_tab.dart';
import 'package:fyp/Screens/Products/Series/series_6_tab.dart';
import 'package:fyp/constants.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text(
            "Products",
            style: TextStyle(
                fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0, color: Colors.black),
          ),
          toolbarHeight: 40.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.0,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: hintColor,
            indicatorWeight: 2,
            indicatorColor: buttonColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Text(
                "REMDII® Sensitive Series",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "REMDII® Skincare Series",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "REMDII® Care Series",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "REMDII® Aurora Gentle Protection Series",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "Aurora",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              Text(
                "Others",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          // title: Text(
          //   'Products',
          //   style: TextStyle(
          //       fontFamily: 'Lato',
          //       fontWeight: FontWeight.w800,
          //       fontSize: 22.0),
          // ),
        ),
        body: TabBarView(
          children: [
            PSeries1Tab(),
            PSeries2Tab(),
            PSeries3Tab(),
            PSeries4Tab(),
            PSeries5Tab(),
            PSeries6Tab(),
          ],
        ),
      ),
    );
  }
}
