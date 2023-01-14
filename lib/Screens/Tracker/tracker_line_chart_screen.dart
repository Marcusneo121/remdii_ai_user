import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fyp/DB_Models/Tracker/LineChartPoint.dart';
import 'package:fyp/DB_Models/Tracker/LineChartTracker.dart';
import 'package:fyp/DB_Models/Tracker/SummaryDifferences.dart';
import 'package:fyp/Screens/Tracker/widgets/lineChartWidget.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class TrackerLineChartScreen extends StatefulWidget {
  const TrackerLineChartScreen(
      {super.key,
      required this.year,
      required this.month,
      required this.monthTitle});
  final String year, month, monthTitle;

  @override
  State<TrackerLineChartScreen> createState() => _TrackerLineChartScreenState();
}

class LineChartDataCarry {
  final int lineChartID;
  final int? radarChartID;
  final String onPressedTitle;
  final int weekLevel;

  LineChartDataCarry({
    required this.lineChartID,
    required this.radarChartID,
    required this.onPressedTitle,
    required this.weekLevel,
  });
}

class _TrackerLineChartScreenState extends State<TrackerLineChartScreen> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _futureDataResults;
  List<LineChartTracker> lineChartData = [];
  List<double> data = <double>[];
  List<LineChartDataCarry> dataCarryLineChart = [];
  List<int?> weekLevel = [];
  List<SummaryDifferentiate> summaryDiffer = [];
  List<String> titleList = [
    "Egg",
    "Cow's Milk",
    "Soy",
    "Peanut",
    "Seafood",
    "Wheat",
    "Dust",
    "Sun",
    "Sweat",
    "Pets",
    "Fragrance",
    "Rubber",
    "Nickel",
    "Formaldehyde",
    "Preservatives",
    "Sanitiser",
    "Moisturizer",
    "Steroids",
    "Medicines",
    "Immunosuppressant",
    "Wet Wrap Therapy",
    "Bleach Bath"
  ];
  List<int> weekNum1DataBoolean = [];
  List<int> weekNum2DataBoolean = [];

  String weekNum1 = "1";
  String weekNum2 = "2";
  bool summaryLoading = false;

  @override
  void initState() {
    _futureDataResults = fetchLineChartData();
    super.initState();
  }

  List<LineChartPoint> get getlineChartPoints {
    return data
        .mapIndexed(((index, element) =>
            LineChartPoint(x: index.toDouble(), y: element.toDouble())))
        .toList();
  }

  fetchLineChartData() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      for (var i = 1; i <= 4; i++) {
        var lineChartTrackerResults = await conn.query(
            'SELECT * FROM lineChart WHERE user_id = ? AND year = ? AND month = ? AND week = ? ORDER BY week ASC',
            [
              prefs.getInt('userID'),
              widget.year,
              widget.month,
              i.toString(),
            ]);

        print(lineChartTrackerResults);

        switch (i) {
          case 1:
            if (lineChartTrackerResults.isEmpty) {
              lineChartData.add(LineChartTracker(
                lineChartID: 0,
                weekLevel: 0,
                poem: 0,
                publishedAt: null,
                month: widget.month,
                week: '1',
                year: widget.year,
                radarChartID: null,
                onPressedTitle: 'No record yet.',
              ));
              weekLevel.add(null);
            } else {
              for (var row in lineChartTrackerResults) {
                lineChartData.add(LineChartTracker(
                  lineChartID: row[0],
                  weekLevel: row[1],
                  poem: row[2],
                  publishedAt: row[3],
                  month: row[5],
                  week: row[6],
                  year: row[7],
                  radarChartID: row[8],
                  onPressedTitle: row[2].toString(),
                ));
                weekLevel.add(row[1]);
              }
            }
            break;
          case 2:
            if (lineChartTrackerResults.isEmpty) {
              lineChartData.add(LineChartTracker(
                lineChartID: 0,
                weekLevel: 0,
                poem: 0,
                publishedAt: null,
                month: widget.month,
                week: '2',
                year: widget.year,
                radarChartID: null,
                onPressedTitle: 'No record yet.',
              ));
              weekLevel.add(null);
            } else {
              for (var row in lineChartTrackerResults) {
                lineChartData.add(LineChartTracker(
                  lineChartID: row[0],
                  weekLevel: row[1],
                  poem: row[2],
                  publishedAt: row[3],
                  month: row[5],
                  week: row[6],
                  year: row[7],
                  radarChartID: row[8],
                  onPressedTitle: row[2].toString(),
                ));
                weekLevel.add(row[1]);
              }
            }
            break;
          case 3:
            if (lineChartTrackerResults.isEmpty) {
              lineChartData.add(LineChartTracker(
                lineChartID: 0,
                weekLevel: 0,
                poem: 0,
                publishedAt: null,
                month: widget.month,
                week: '3',
                year: widget.year,
                radarChartID: null,
                onPressedTitle: 'No record yet.',
              ));
              weekLevel.add(null);
            } else {
              for (var row in lineChartTrackerResults) {
                lineChartData.add(LineChartTracker(
                  lineChartID: row[0],
                  weekLevel: row[1],
                  poem: row[2],
                  publishedAt: row[3],
                  month: row[5],
                  week: row[6],
                  year: row[7],
                  radarChartID: row[8],
                  onPressedTitle: row[2].toString(),
                ));
                weekLevel.add(row[1]);
              }
            }
            break;
          case 4:
            if (lineChartTrackerResults.isEmpty) {
              lineChartData.add(LineChartTracker(
                lineChartID: 0,
                weekLevel: 0,
                poem: 0,
                publishedAt: null,
                month: widget.month,
                week: '4',
                year: widget.year,
                radarChartID: null,
                onPressedTitle: 'No record yet.',
              ));
              weekLevel.add(null);
            } else {
              for (var row in lineChartTrackerResults) {
                lineChartData.add(LineChartTracker(
                  lineChartID: row[0],
                  weekLevel: row[1],
                  poem: row[2],
                  publishedAt: row[3],
                  month: row[5],
                  week: row[6],
                  year: row[7],
                  radarChartID: row[8],
                  onPressedTitle: row[2].toString(),
                ));
                weekLevel.add(row[1]);
              }
            }
            break;
          default:
            break;
        }
      }

      for (var item in lineChartData) {
        data.add(item.weekLevel.toDouble());
        dataCarryLineChart.add(LineChartDataCarry(
          lineChartID: item.lineChartID,
          radarChartID: item.radarChartID,
          onPressedTitle: item.onPressedTitle,
          weekLevel: item.weekLevel,
        ));
      }

      await fetchCompareData(conn, prefs, weekNum1, weekNum2);

      await conn.close();
      return lineChartData;
    } catch (e) {
      print("Error message : $e");
    }
  }

  fetchCompareData(var conn, SharedPreferences prefs, String weekNum1,
      String weekNum2) async {
    try {
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var week1SummaryTrackerResults = await conn.query(
          'SELECT * FROM radarChartData WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
          [
            prefs.getInt('userID'),
            weekNum1,
            widget.month,
            widget.year,
          ]);

      var week2SummaryTrackerResults = await conn.query(
          'SELECT * FROM radarChartData WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
          [
            prefs.getInt('userID'),
            weekNum2,
            widget.month,
            widget.year,
          ]);

      print(week1SummaryTrackerResults);
      print(week2SummaryTrackerResults);

      weekNum1DataBoolean.clear();
      weekNum2DataBoolean.clear();

      for (var row1 in week1SummaryTrackerResults) {
        for (var rowNum = 3; rowNum <= 24; rowNum++) {
          weekNum1DataBoolean.add(row1[rowNum]);
          //print(row1[rowNum]);
        }
      }

      for (var row2 in week2SummaryTrackerResults) {
        for (var rowNum = 3; rowNum <= 24; rowNum++) {
          weekNum2DataBoolean.add(row2[rowNum]);
          //print(row2[rowNum]);
        }
      }

      for (var i = 0; i < titleList.length; i++) {
        if (weekNum1DataBoolean[i] != weekNum2DataBoolean[i]) {
          // print(
          //     "${titleList[i].toString()} => ${weekNum1DataBoolean[i]} : ${weekNum2DataBoolean[i]}");
          summaryDiffer.add(SummaryDifferentiate(
            title: titleList[i],
            weekNum1: weekNum1DataBoolean[i] == 1 ? true : false,
            weekNum2: weekNum2DataBoolean[i] == 1 ? true : false,
          ));
        } else {
          // print(
          //     "${titleList[i].toString()} are equal value. ${weekNum1DataBoolean[i]} : ${weekNum2DataBoolean[i]}");
        }
      }

      // for (var row1 in week1SummaryTrackerResults) {
      //   for (var row2 in week2SummaryTrackerResults) {
      //     for (var rowNum = 3; rowNum <= 24; rowNum++) {
      //       print('${row1[rowNum]} : ${row2[rowNum]}');
      //       for (var i = 0; i < titleList.length; i++) {
      //         if (row1[rowNum] == 1 && row2[rowNum] == 1) {
      //           print(
      //               "${titleList[i].toString()} are equal value. ${row1[rowNum]} : ${row2[rowNum]}");
      //         } else if (row1[rowNum] == 0 && row2[rowNum] == 0) {
      //           print(
      //               "${titleList[i].toString()} are equal value. ${row1[rowNum]} : ${row2[rowNum]}");
      //         } else {
      //           summaryDiffer.add(SummaryDifferentiate(
      //             title: titleList[i],
      //             weekNum1: row1[rowNum] == 1 ? true : false,
      //             weekNum2: row2[rowNum] == 1 ? true : false,
      //           ));
      //         }
      //       }
      //     }
      //   }
      // }

      setState(() {
        summaryLoading = false;
      });
    } catch (e) {
      print("Error message : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.monthTitle.toString(),
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
        child: Center(
          child: FutureBuilder(
              future: _futureDataResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.length > 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 25, top: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 70,
                            child: LineChartWidget(
                                points: getlineChartPoints,
                                year: widget.year,
                                month: widget.month,
                                monthTitle: widget.monthTitle,
                                context: context,
                                dataCollections: dataCarryLineChart),
                          ),
                        ),
                        SizedBox(height: 20),
                        summaryLoading == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Summary',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 1,
                                    margin: EdgeInsets.only(right: 20),
                                    color: Colors.black.withOpacity(0.4),
                                    width: 75,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 260,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Week 1',
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              Text(
                                                'Week 2',
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              Text(
                                                'Week 3',
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              Text(
                                                'Week 4',
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Bounceable(
                                              onTap: () async {
                                                Vibration.vibrate(
                                                    amplitude: 40,
                                                    duration: 200);
                                                var conn = await MySqlConnection
                                                    .connect(settings);
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                if (weekNum1 != "1" &&
                                                    weekNum2 != "2") {
                                                  setState(() {
                                                    summaryLoading = true;
                                                    weekNum1 = "1";
                                                    weekNum2 = "2";
                                                  });
                                                  await fetchCompareData(
                                                      conn,
                                                      prefs,
                                                      weekNum1,
                                                      weekNum2);
                                                }
                                              },
                                              child: Container(
                                                width: 70,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                      spreadRadius: 2,
                                                      blurRadius: 3,
                                                      offset: Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: Colors.red[400],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Bounceable(
                                              onTap: () async {
                                                Vibration.vibrate(
                                                    amplitude: 40,
                                                    duration: 200);
                                                var conn = await MySqlConnection
                                                    .connect(settings);
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                if (weekNum1 != "2" &&
                                                    weekNum2 != "3") {
                                                  setState(() {
                                                    summaryLoading = true;
                                                    weekNum1 = "2";
                                                    weekNum2 = "3";
                                                  });
                                                  await fetchCompareData(
                                                      conn,
                                                      prefs,
                                                      weekNum1,
                                                      weekNum2);
                                                }
                                              },
                                              child: Container(
                                                width: 70,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                      spreadRadius: 2,
                                                      blurRadius: 3,
                                                      offset: Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green[400],
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Bounceable(
                                              onTap: () async {
                                                Vibration.vibrate(
                                                    amplitude: 40,
                                                    duration: 200);
                                                var conn = await MySqlConnection
                                                    .connect(settings);
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                if (weekNum1 != "3" &&
                                                    weekNum2 != "4") {
                                                  setState(() {
                                                    summaryLoading = true;
                                                    weekNum1 = "3";
                                                    weekNum2 = "4";
                                                  });
                                                  await fetchCompareData(
                                                      conn,
                                                      prefs,
                                                      weekNum1,
                                                      weekNum2);
                                                }
                                              },
                                              child: Container(
                                                width: 70,
                                                height: 50,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                      spreadRadius: 2,
                                                      blurRadius: 3,
                                                      offset: Offset(0,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.red[400],
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 120),
                                      CircularProgressIndicator(
                                        color: buttonColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
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
              }),
        ),
      ),
    );
  }
}
