import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fyp/DB_Models/Tracker/LineChartDataCarry.dart';
import 'package:fyp/DB_Models/Tracker/LineChartPoint.dart';
import 'package:fyp/DB_Models/Tracker/LineChartTracker.dart';
import 'package:fyp/DB_Models/Tracker/SummaryDifferences.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/Tracker/widgets/lineChartWidget.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class TrackerLineChartCompleteScreen extends StatefulWidget {
  const TrackerLineChartCompleteScreen(
      {super.key,
      required this.year,
      required this.month,
      required this.monthTitle});
  final String year, month, monthTitle;

  @override
  State<TrackerLineChartCompleteScreen> createState() =>
      _TrackerLineChartCompleteScreenState();
}

class _TrackerLineChartCompleteScreenState
    extends State<TrackerLineChartCompleteScreen> {
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
  bool week1Empty = false;
  bool week2Empty = false;

  List<String> titleUI = [];
  List<bool?> weekNum1UI = [];
  List<bool?> weekNum2UI = [];

  Color colorBox1 = Colors.grey;
  Color colorBox2 = Colors.grey;
  Color colorBox3 = Colors.grey;

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
      weekLevel.clear();
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

        // if (lineChartTrackerResults.isEmpty) {
        //   weekLevel.add(null);
        // } else {
        //   for (var rowWeekLevel in lineChartTrackerResults) {
        //     print(rowWeekLevel[1]);
        //     weekLevel.add(rowWeekLevel[1]);
        //   }
        // }

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
      print(weekLevel[0]);
      print(weekLevel[1]);
      print(weekLevel[2]);
      print(weekLevel[3]);
      if (weekLevel[0] == null || weekLevel[1] == null) {
        colorBox1 = Colors.white;
      } else {
        if (weekLevel[0]! > weekLevel[1]!) {
          colorBox1 = Colors.green[400]!;
        } else if (weekLevel[0]! == weekLevel[1]!) {
          colorBox1 = Colors.grey;
        } else {
          colorBox1 = Colors.red[400]!;
        }
      }

      if (weekLevel[1] == null || weekLevel[2] == null) {
        colorBox2 = Colors.white;
      } else {
        if (weekLevel[1]! > weekLevel[2]!) {
          colorBox2 = Colors.green[400]!;
        } else if (weekLevel[1]! == weekLevel[2]!) {
          colorBox2 = Colors.grey;
        } else {
          colorBox2 = Colors.red[400]!;
        }
      }

      if (weekLevel[2] == null || weekLevel[3] == null) {
        colorBox3 = Colors.white;
      } else {
        if (weekLevel[2]! > weekLevel[3]!) {
          colorBox3 = Colors.green[400]!;
        } else if (weekLevel[2]! == weekLevel[3]!) {
          colorBox3 = Colors.grey;
        } else {
          colorBox3 = Colors.red[400]!;
        }
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
      titleUI.clear();
      weekNum1UI.clear();
      weekNum2UI.clear();
      summaryDiffer.clear();
      week1Empty = false;
      week2Empty = false;

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
      if (weekNum1DataBoolean.isEmpty) {
        week1Empty = true;
      }
      if (weekNum2DataBoolean.isEmpty) {
        week2Empty = true;
      }

      if (week1Empty == true && week2Empty == false) {
        for (var i = 0; i < titleList.length; i++) {
          summaryDiffer.add(SummaryDifferentiate(
            title: titleList[i],
            weekNum1: null,
            weekNum2: weekNum2DataBoolean[i] == 1 ? true : false,
          ));
        }
      } else if (week1Empty == false && week2Empty == true) {
        for (var i = 0; i < titleList.length; i++) {
          summaryDiffer.add(SummaryDifferentiate(
            title: titleList[i],
            weekNum1: weekNum1DataBoolean[i] == 1 ? true : false,
            weekNum2: null,
          ));
        }
      } else if (week1Empty == true && week2Empty == true) {
        summaryDiffer.clear();
      } else if (week1Empty == false && week2Empty == false) {
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

      for (var item in summaryDiffer) {
        titleUI.add(item.title);
      }

      for (var itemWeek1 in summaryDiffer) {
        if (itemWeek1.weekNum1 != null) {
          weekNum1UI.add(itemWeek1.weekNum1);
        }
      }

      for (var itemWeek2 in summaryDiffer) {
        if (itemWeek2.weekNum2 != null) {
          weekNum2UI.add(itemWeek2.weekNum2);
        }
      }

      setState(() {
        summaryLoading = false;
      });
    } catch (e) {
      print("Error message : $e");
    }
  }

  Widget summaryUIGenerator() {
    if (weekNum1UI.isEmpty && weekNum2UI.isNotEmpty) {
      return Container(
        child: Center(
          child: Text("Week ${weekNum1} data is empty. No Summary available"),
        ),
      );
    } else if (weekNum1UI.isNotEmpty && weekNum2UI.isEmpty) {
      return Container(
        child: Center(
          child: Text("Week ${weekNum2} data is empty. No Summary available"),
        ),
      );
    } else if (weekNum1UI.isEmpty && weekNum2UI.isEmpty) {
      return Container(
        child: Center(
          child: Column(
            children: [
              Text("Week ${weekNum1} and Week ${weekNum2} data is empty,"),
              Text('No summary available.')
            ],
          ),
        ),
      );
    } else {
      return Bounceable(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width - 60,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.only(top: 0.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: titleUI.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        // decoration: BoxDecoration(
                        //   color: Colors.amberAccent,
                        //   borderRadius: BorderRadius.circular(10),
                        //   border: Border.all(
                        //     color: Colors.black,
                        //     width: 2,
                        //   ),
                        // ),
                        color: Colors.green.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            titleUI[index].toString(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: snapshot.data.length,
                    itemCount: weekNum1UI.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (weekNum1UI.isEmpty) {
                        return Container(
                          child: Center(
                            child: Text("Empty"),
                          ),
                        );
                      } else {
                        return Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            //borderRadius: BorderRadius.circular(10),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 2,
                            // ),
                          ),
                          child: Center(
                            child: weekNum1UI[index] == true
                                ? Icon(
                                    Icons.done_rounded,
                                  )
                                : Icon(
                                    Icons.close_rounded,
                                  ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: snapshot.data.length,
                    itemCount: weekNum2UI.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (weekNum2UI.isEmpty) {
                        return Container(
                          child: Center(
                            child: Text("Empty"),
                          ),
                        );
                      } else {
                        return Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            //borderRadius: BorderRadius.circular(10),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 2,
                            // ),
                          ),
                          child: Center(
                            child: weekNum2UI[index] == true
                                ? Icon(
                                    Icons.done_rounded,
                                  )
                                : Icon(
                                    Icons.close_rounded,
                                  ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (BuildContext context) => HomepageScreen(),
                ),
                (route) => false,
              );
            }),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Summary',
                                style: TextStyle(
                                  //fontFamily: 'Lato',
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
                                width: 260,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                                color: Colors.green[400],
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            "Healing",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                                color: Colors.red[400],
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            "Worsen",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            "Neutral",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            "Empty",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 20),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
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
                                                amplitude: 40, duration: 200);
                                            var conn =
                                                await MySqlConnection.connect(
                                                    settings);
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
                                              await fetchCompareData(conn,
                                                  prefs, weekNum1, weekNum2);
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
                                              color: colorBox1,
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
                                                amplitude: 40, duration: 200);
                                            var conn =
                                                await MySqlConnection.connect(
                                                    settings);
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
                                              await fetchCompareData(conn,
                                                  prefs, weekNum1, weekNum2);
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
                                              color: colorBox2,
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
                                                amplitude: 40, duration: 200);
                                            var conn =
                                                await MySqlConnection.connect(
                                                    settings);
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
                                              await fetchCompareData(conn,
                                                  prefs, weekNum1, weekNum2);
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
                                              color: colorBox3,
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
                          ),
                          SizedBox(height: 20),
                          summaryLoading == false
                              ? Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  190,
                                              color:
                                                  Colors.green.withOpacity(0.5),
                                              child: Center(
                                                  child: Text(
                                                "Items",
                                                style: TextStyle(
                                                  //fontFamily: 'Lato',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19.0,
                                                ),
                                              )),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    190,
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                child: Center(
                                                    child: Text(
                                                  "Week ${weekNum1.toString()}",
                                                  style: TextStyle(
                                                    //fontFamily: 'Lato',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    190,
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                child: Center(
                                                    child: Text(
                                                  "Week ${weekNum2.toString()}",
                                                  style: TextStyle(
                                                    //fontFamily: 'Lato',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    summaryUIGenerator(),
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
                          SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return Center(child: Text('Your history is empty now.'));
                    }
                  }
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        CircularProgressIndicator(
                          color: buttonColor,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
