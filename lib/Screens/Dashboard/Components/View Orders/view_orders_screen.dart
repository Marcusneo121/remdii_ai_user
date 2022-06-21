import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/OrderInfoScreen.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/completed_orders_tab.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/toship_orders_tab.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/paid_order_tab.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/ongoing_orders_tab.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/unpaid_order_tab.dart';
import 'package:fyp/constants.dart';

class ViewOrders extends StatefulWidget {
  const ViewOrders({Key? key}) : super(key: key);

  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "View Orders",
              style: TextStyle(
                  fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0, color: Colors.black),
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
                          return OrderInfoScreen();
                        },
                      ),
                    );
                  })
            ],
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.0,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: hintColor,
              indicatorWeight: 2,
              indicatorColor: buttonColor,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              tabs: [
                Text(
                  "Unpaid",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Paid",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "To Ship",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Ongoing",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Completed",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              UnpaidOrderTab(),
              PaidOrderTab(),
              ToShipOrderTab(),
              OngoingOrderTab(),
              CompletedOrderTab(),
            ],
          ),
        ),
      );

  }
}
