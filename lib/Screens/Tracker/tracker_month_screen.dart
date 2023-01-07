import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fyp/DB_Models/Tracker/MonthTracker.dart';
import 'package:fyp/DB_Models/Tracker/YearTracker.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class TrackerMonthScreen extends StatefulWidget {
  const TrackerMonthScreen({super.key, required this.year});
  final String year;

  @override
  State<TrackerMonthScreen> createState() => _TrackerMonthScreenState();
}

class _TrackerMonthScreenState extends State<TrackerMonthScreen> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _futureDataResults;
  List<MonthTracker> monthList = [];

  @override
  void initState() {
    print(widget.year.toString());
    _futureDataResults = fetchYearData();
    super.initState();
  }

  fetchYearData() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var yearTrackerResults = await conn.query(
          'SELECT * FROM lineChart WHERE user_id = ? AND year = ? ORDER BY month ASC',
          [prefs.getInt('userID'), widget.year]);

      print(yearTrackerResults);
      for (var row in yearTrackerResults) {
        if (monthList.any((monthTracker) => monthTracker.month == row[5])) {
          print('Same year appear, so skipped.');
        } else {
          monthList.add(
            MonthTracker(
              lineChartID: row[0],
              weekLevel: row[1],
              poem: row[2],
              publishedAt: row[3],
              userID: row[4],
              month: row[5],
              week: row[6],
              year: row[7],
              radarChartID: row[8],
              monthTitle: monthFinder(row[5]),
            ),
          );
        }
      }
      return monthList;
    } catch (e) {
      print("Error message : $e");
    }
  }

  String monthFinder(String monthNumber) {
    String foundTitle = '';

    switch (monthNumber) {
      case '01':
        foundTitle = 'January';
        break;
      case '02':
        foundTitle = 'February';
        break;
      case '03':
        foundTitle = 'March';
        break;
      case '04':
        foundTitle = 'April';
        break;
      case '05':
        foundTitle = 'May';
        break;
      case '06':
        foundTitle = 'June';
        break;
      case '07':
        foundTitle = 'July';
        break;
      case '08':
        foundTitle = 'August';
        break;
      case '09':
        foundTitle = 'September';
        break;
      case '10':
        foundTitle = 'October';
        break;
      case '11':
        foundTitle = 'November';
        break;
      case '12':
        foundTitle = 'December';
        break;
      default:
        foundTitle = 'Error';
        break;
    }

    return foundTitle;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.year.toString(),
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w800,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder(
          future: _futureDataResults,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length > 0) {
                return Container(
                  padding: EdgeInsets.only(top: 0.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    // itemCount: snapshot.data.length,
                    itemCount: monthList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Bounceable(
                        onTap: () {
                          Vibration.vibrate(amplitude: 128);
                          // Navigator.push(
                          //   context,
                          //   CupertinoPageRoute(
                          //     builder: (BuildContext context) =>
                          //         TrackerMonthScreen(
                          //       year: monthList[index].year.toString(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          width: size.width,
                          height: 80,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              width: size.width,
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    monthList[index].monthTitle.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('Your order history is empty now.'));
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
