import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Order.dart';
import 'package:fyp/DB_Models/OrderDetails.dart';
import 'package:fyp/DB_Models/Products.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/completed_order_details_screen.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedOrderTab extends StatefulWidget {
  const CompletedOrderTab({Key? key}) : super(key: key);

  @override
  _CompletedOrderTabState createState() => _CompletedOrderTabState();
}

class _CompletedOrderTabState extends State<CompletedOrderTab> {
  // final List<String> order_date = <String>[
  //   '12 NOV 2021',
  //   '14 NOV 2021',
  //   '16 NOV 2021',
  // ];
  // var numOfItems = [1, 2, 1];
  // var totalPayment = [70.00, 25.00, 65.00];
  // final List<String> prod_img = <String>[
  //   'assets/images/REMDII Intensive Moisturising Cream 112ml.png',
  //   'assets/images/intensive_moisturing_cream.png',
  //   'assets/images/remdii_senstive_scalp_repair_spray.png',
  // ];

  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    _future = fetchOrderData();
    super.initState();
  }

  fetchOrderData() async {
    try {
      List<Order> orderList = [];
      List<OrderDetails> orderDetail = [];
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var orderIDResults = await conn.query(
          'SELECT * FROM orderhistory WHERE user_id = ?',
          [prefs.getInt('userID')]);
      for (var row1 in orderIDResults) {
        // print(id[0]);
        var detailResults = await conn.query(
            'SELECT prod_img, name, prod_desc, add_info, stock, '
            'orderdetails.prodID, series_id, price, qty, totalPrice, orderhistory.orderID, status '
            'FROM products, orderdetails, orderhistory '
            'WHERE orderdetails.prodID = products.prod_id '
            'AND orderhistory.orderID = orderdetails.orderID '
            'AND status = "Completed" '
            'AND orderhistory.user_id = ? AND orderdetails.orderID = ? AND orderhistory.orderID = ? ',
            // [prefs.getInt('userID').toString()]);
            [
              prefs.getInt('userID').toString(),
              row1[0].toString(),
              row1[0].toString()
            ]);
        print('hahahah');
        print(row1[0]);

        for (var row in detailResults) {
          orderDetail.add(OrderDetails(
              products: Product(
                  prod_img: row[0].toString(),
                  name: row[1],
                  prod_desc: row[2].toString(),
                  add_info: row[3].toString(),
                  stock: row[4],
                  prod_id: row[5],
                  series_id: row[6],
                  price: row[7]),
              qty: row[8],
              totalPrice: row[9],
              orderID: row[10].toString()));
        }
        print('a');
        var orderResults = await conn.query(
            'SELECT orderTime, orderDate, orderAmt, shippingFee, '
            'orderID, status, trackingNo, user_id, completedDate, completedTime, shippedDate, shippedTime, paymentImg '
            'FROM orderhistory WHERE status = "Completed" '
            'AND user_id = ? AND orderID = ?',
            [prefs.getInt('userID').toString(), row1[0].toString()]);
        print('aa');
        for (var row in orderResults) {
          orderList.add(
            Order(
                orderTime: row[0],
                orderDate: row[1],
                orderDetails: orderDetail,
                amount: row[2],
                shippingFee: row[3],
                orderID: row[4].toString(),
                status: row[5],
                trackingNo: row[6],
                comTime: row[9],
                comDate: row[8],
                shippedTime: row[10],
                shippedDate: row[11],
                paymentImg: row[12].toString()),
          );
        }
        orderDetail = [];
        print(orderResults);
        print(orderList.length);
        print('orderlist ' + orderList.toString());
        print('orderDetails ' + orderDetail.toString());
        print(orderDetail.length);
      }
      return orderList;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length > 0) {
              return Container(
                padding: EdgeInsets.only(top: 15.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    width: size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 110.0,
                                height: 100.0,
                                child: Image.memory(
                                  base64.decode(
                                      '${snapshot.data[index].orderDetails[0].products.prod_img}'),
                                  fit: BoxFit.fill,
                                  width: 110.0,
                                  height: 100.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Order Date: ${snapshot.data[index].orderDate}',
                                    style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    '${snapshot.data[index].orderDetails.length} ITEM(S)',
                                    style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    'TOTAL PAYMENT: RM ${snapshot.data[index].amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CompletedOrderDetails(
                                              order: snapshot.data[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          buttonColor, // background (button) color
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Center(child: Text('Your order history is empty now.'));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
