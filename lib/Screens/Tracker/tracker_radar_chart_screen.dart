import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fyp/DB_Models/Tracker/LineChartPoint.dart';
import 'package:fyp/DB_Models/Tracker/LineChartTracker.dart';
import 'package:fyp/DB_Models/Tracker/RadarChartRawDataSet.dart';
import 'package:fyp/Screens/Tracker/widgets/lineChartWidget.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/Screens/Tracker/widgets/radarChartWidget/careRoutineRadarChartWidget.dart';
import 'package:fyp/Screens/Tracker/widgets/radarChartWidget/contactAllergensRadarChartWidget.dart';
import 'package:fyp/Screens/Tracker/widgets/radarChartWidget/environmentRadarChartWidget.dart';
import 'package:fyp/Screens/Tracker/widgets/radarChartWidget/foodRadarChartWidget.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerRadarChartScreen extends StatefulWidget {
  const TrackerRadarChartScreen({
    super.key,
    required this.year,
    required this.month,
    required this.week,
    required this.monthTitle,
    required this.radarChartID,
  });
  final String year, month, monthTitle, week;
  final int? radarChartID;

  @override
  State<TrackerRadarChartScreen> createState() =>
      _TrackerRadarChartScreenState();
}

class _TrackerRadarChartScreenState extends State<TrackerRadarChartScreen> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _futureDataResults;
  List<RawDataSet> foodRadarData = [];
  List<RawDataSet> environmentRadarData = [];
  List<RawDataSet> contactAllergensRadarData = [];
  List<RawDataSet> careRoutineRadarData = [];

  @override
  void initState() {
    _futureDataResults = fetchLineChartData();
    super.initState();
  }

  fetchLineChartData() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var radarChartTrackerResults =
          await conn.query('SELECT * FROM radarChart WHERE radarChartID = ?', [
        widget.radarChartID,
      ]);

      for (var row in radarChartTrackerResults) {
        var radarChartDataResults = await conn
            .query('SELECT * FROM radarChartData WHERE radarChartDataID = ?', [
          row[6],
        ]);

        for (var row in radarChartDataResults) {
          foodRadarData.add(
            RawDataSet(
              title: 'Foods',
              color: Colors.brown,
              values: [
                row[3] == 1 ? 300 : 0,
                row[4] == 1 ? 300 : 0,
                row[5] == 1 ? 300 : 0,
                row[6] == 1 ? 300 : 0,
                row[7] == 1 ? 300 : 0,
                row[8] == 1 ? 300 : 0
              ],
            ),
          );

          environmentRadarData.add(
            RawDataSet(
              title: 'Environment',
              color: artColor,
              values: [
                row[9] == 1 ? 300 : 0,
                row[10] == 1 ? 300 : 0,
                row[11] == 1 ? 300 : 0,
                row[12] == 1 ? 300 : 0,
              ],
            ),
          );

          contactAllergensRadarData.add(
            RawDataSet(
              title: 'Contact Allergens',
              color: offRoadColor,
              values: [
                row[13] == 1 ? 300 : 0,
                row[14] == 1 ? 300 : 0,
                row[15] == 1 ? 300 : 0,
                row[16] == 1 ? 300 : 0,
                row[17] == 1 ? 300 : 0,
                row[18] == 1 ? 300 : 0
              ],
            ),
          );

          careRoutineRadarData.add(
            RawDataSet(
              title: 'Care Routine',
              color: Colors.pink,
              values: [
                row[19] == 1 ? 300 : 0,
                row[20] == 1 ? 300 : 0,
                row[21] == 1 ? 300 : 0,
                row[22] == 1 ? 300 : 0,
                row[23] == 1 ? 300 : 0,
                row[24] == 1 ? 300 : 0,
              ],
            ),
          );
        }
      }
      await conn.close();
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
          '${widget.monthTitle} - Week ${widget.week}',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Center(
            child: FutureBuilder(
                future: _futureDataResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Bounceable(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(top: 15, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFF241F48),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Food',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Divider(
                                  thickness: 1.2,
                                  color: Colors.grey[400],
                                  height: 30,
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: FoodRadarChartWidget(
                                    foodRawData: foodRadarData,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Bounceable(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(top: 15, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFF241F48),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Environment',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Divider(
                                  thickness: 1.2,
                                  color: Colors.grey[400],
                                  height: 30,
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: EnvironmentRadarChartWidget(
                                    environmentRawData: environmentRadarData,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Bounceable(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(top: 15, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFF241F48),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Contact Allergens',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Divider(
                                  thickness: 1.2,
                                  color: Colors.grey[400],
                                  height: 30,
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: ContactAllergensRadarChartWidget(
                                    contactAllergensRawData:
                                        contactAllergensRadarData,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Bounceable(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(top: 15, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFF241F48),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Care Routine',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Divider(
                                  thickness: 1.2,
                                  color: Colors.grey[400],
                                  height: 30,
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: CareRoutineRadarChartWidget(
                                    careRoutineRawData: careRoutineRadarData,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
