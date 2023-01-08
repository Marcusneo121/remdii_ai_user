import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fyp/DB_Models/Tracker/YearTracker.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/Screens/Tracker/tracker_month_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class TrackerMainScreen extends StatefulWidget {
  const TrackerMainScreen({super.key});

  @override
  State<TrackerMainScreen> createState() => _TrackerMainScreenState();
}

class _TrackerMainScreenState extends State<TrackerMainScreen> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _futureDataResults;
  List<YearTracker> yearList = [];

  @override
  void initState() {
    // TODO: implement initState
    _futureDataResults = fetchYearData();
    super.initState();
  }

  fetchYearData() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var yearTrackerResults = await conn.query(
          'SELECT * FROM lineChart WHERE user_id = ? ORDER BY year DESC',
          [prefs.getInt('userID')]);

      for (var row in yearTrackerResults) {
        if (yearList.any((yearTracker) => yearTracker.year == row[7])) {
          print('Same year appear, so skipped.');
        } else {
          yearList.add(
            YearTracker(
              lineChartID: row[0],
              weekLevel: row[1],
              poem: row[2],
              publishedAt: row[3],
              userID: row[4],
              month: row[5],
              week: row[6],
              year: row[7],
              radarChartID: row[8],
            ),
          );
        }
      }
      await conn.close();
      return yearList;
    } catch (e) {
      print("Error message : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tracker",
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
                    itemCount: yearList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Bounceable(
                        onTap: () {
                          //Vibration.vibrate(amplitude: 128);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  TrackerMonthScreen(
                                year: yearList[index].year.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: size.width,
                          height: 80,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: size.width,
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    yearList[index].year.toString(),
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
                return Center(child: Text('Your history is empty now.'));
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: buttonColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
