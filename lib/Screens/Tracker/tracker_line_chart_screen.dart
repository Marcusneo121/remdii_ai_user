import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:fyp/DB_Models/Tracker/LineChartPoint.dart';
import 'package:fyp/DB_Models/Tracker/LineChartTracker.dart';
import 'package:fyp/Screens/Tracker/widgets/lineChartWidget.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      await conn.close();
      return lineChartData;
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 19, top: 20),
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
