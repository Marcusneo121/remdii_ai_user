import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/CaseDetails.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fyp/DB_Models/connection.dart';

class ViewReportScreen extends StatefulWidget {
  const ViewReportScreen({Key? key, required this.caseID}) : super(key: key);
  final int caseID;

  @override
  _ViewReportScreenState createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  // final List<String> diagnose_result = <String>[
  //   'Eczema',
  //   'Eczema',
  //   'Eczema',
  //   'Eczema',
  //   'Eczema'
  // ];
  // final List<String> diagnose_date = <String>[
  //   '17 DEC 2021',
  //   '20 DEC 2021',
  //   '22 DEC 2021',
  //   '25 DEC 2021',
  //   '31 DEC 2021',
  // ];
  // final List<String> diagnose_img = <String>[
  //   'assets/images/eczema_1.jpg',
  //   'assets/images/eczema_1.jpg',
  //   'assets/images/eczema_1.jpg',
  //   'assets/images/eczema_1.jpg',
  //   'assets/images/eczema_1.jpg',
  // ];
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  // final valueController = Controller();

  @override
  void initState() {
    _future = fetchCaseData();
    // splitImg();
    super.initState();
  }

  fetchCaseData() async {
    try {
      List<CaseDetails> caseDetails = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var conn = await MySqlConnection.connect(settings);
      var results = await conn.query(
          'SELECT caseID, detailID, caseImg, '
          'date, time, result, severity, status, sleepingHrs '
          'FROM  casedetails '
          'WHERE caseID = ? '
          'ORDER BY detailID ASC',
          [widget.caseID]);

      for (var row in results) {
        caseDetails.add(CaseDetails(
            caseID: row[0],
            detailID: row[1].toString(),
            caseImg: row[2].toString(),
            date: row[3],
            time: row[4],
            result: row[5],
            severity: row[6],
            status: row[7],
            comments: '',
            foodLog: '',
            sleepTime: '',
            wakeTime: '',
            sleepingHrs: row[8],
            q1: '',
            q2: '',
            q3: '',
            q4: '',
            q1Ans: '',
            q2Ans: '',
            q3Ans: '',
            q4Ans: ''));
      }

      print(caseDetails);
      await conn.close();
      return caseDetails;
    } catch (e) {
      print(e);
    }
  }

  double getSeverityValue(String severity) {
    if (severity.toUpperCase() == "MILD") {
      return 17;
    } else if (severity.toUpperCase() == "MODERATE") {
      return 50;
    } else if (severity.toUpperCase() == "SEVERE") {
      return 83;
    } else {
      return 0;
    }
  }

  double getSleepingValue(int sleepHrs) {
    if (sleepHrs == 0) {
      return -20;
    } else if (sleepHrs < 5) {
      return 83;
    } else if (sleepHrs < 7) {
      return 50;
    } else {
      return 17;
    }
  }

  double get() {
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Detail Progress Report",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
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
                        padding: EdgeInsets.only(left: 10.0, top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: 130.0,
                                    height: 100.0,
                                    child: Image.memory(
                                      base64.decode(snapshot.data[index].caseImg),
                                      fit: BoxFit.fill,
                                      width: 130.0,
                                      height: 100.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Date: ${snapshot.data[index].date}',
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        'Time: ${snapshot.data[index].time}',
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        'Result: ${snapshot.data[index].result}',
                                        // maxLines: 2,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        '[ ${snapshot.data[index].status} ]',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16.0,
                                          color: buttonColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 180,
                                    height: 150,
                                    child: SfRadialGauge(
                                      title: GaugeTitle(
                                          text: 'Severity',
                                          textStyle: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.0,
                                            color: buttonColor,
                                          )),
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          showLabels: false,
                                          showAxisLine: false,
                                          showTicks: false,
                                          minimum: 0,
                                          maximum: 99,
                                          radiusFactor: 0.9,
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 0,
                                                endValue: 33,
                                                color: const Color(0xFF00AB47),
// Added range label
                                                label: 'Mild',
                                                sizeUnit: GaugeSizeUnit.factor,
                                                labelStyle: GaugeTextStyle(
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.0),
                                                startWidth: 0.65,
                                                endWidth: 0.65),
                                            GaugeRange(
                                              startValue: 33,
                                              endValue: 66,
                                              color: const Color(0xFFFFBA00),
// Added range label
                                              label: 'Moderate',
                                              labelStyle: GaugeTextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12.0),
                                              startWidth: 0.65,
                                              endWidth: 0.65,
                                              sizeUnit: GaugeSizeUnit.factor,
                                            ),
                                            GaugeRange(
                                              startValue: 66,
                                              endValue: 99,
                                              color: const Color(0xFFFE2A25),
// Added range label
                                              label: 'Severe',
                                              labelStyle: GaugeTextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12.0),
                                              sizeUnit: GaugeSizeUnit.factor,
                                              startWidth: 0.65,
                                              endWidth: 0.65,
                                            ),
// Added small height range in bottom to show shadow effect.
                                            GaugeRange(
                                              startValue: 0,
                                              endValue: 99,
                                              color: const Color.fromRGBO(
                                                  155, 155, 155, 0.3),
                                              rangeOffset: 0.5,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              startWidth: 0.15,
                                              endWidth: 0.15,
                                            ),
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: getSeverityValue(snapshot
                                                  .data[index].severity),
                                              onValueChangeEnd:
                                                  (double startValue) {},
                                              needleLength: 0.65,
                                              lengthUnit: GaugeSizeUnit.factor,
                                              needleStartWidth: 1,
                                              needleEndWidth: 7,
                                              knobStyle: KnobStyle(
                                                knobRadius: 9,
                                                sizeUnit:
                                                    GaugeSizeUnit.logicalPixel,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 180,
                                    height: 150,
                                    child: SfRadialGauge(
                                      title: GaugeTitle(
                                          text: 'Sleeping Analysis',
                                          textStyle: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16.0,
                                            color: buttonColor,
                                          )),
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          showLabels: false,
                                          showAxisLine: false,
                                          showTicks: false,
                                          minimum: 0,
                                          maximum: 99,
                                          radiusFactor: 0.9,
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 0,
                                                endValue: 33,
                                                color: const Color(0xFF00AB47),
// Added range label
                                                label: 'Good',
                                                sizeUnit: GaugeSizeUnit.factor,
                                                labelStyle: GaugeTextStyle(
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12.0),
                                                startWidth: 0.65,
                                                endWidth: 0.65),
                                            GaugeRange(
                                              startValue: 33,
                                              endValue: 66,
                                              color: const Color(0xFFFFBA00),
// Added range label
                                              label: 'Average',
                                              labelStyle: GaugeTextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12.0),
                                              startWidth: 0.65,
                                              endWidth: 0.65,
                                              sizeUnit: GaugeSizeUnit.factor,
                                            ),
                                            GaugeRange(
                                              startValue: 66,
                                              endValue: 99,
                                              color: const Color(0xFFFE2A25),
// Added range label
                                              label: 'Bad',
                                              labelStyle: GaugeTextStyle(
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12.0),
                                              sizeUnit: GaugeSizeUnit.factor,
                                              startWidth: 0.65,
                                              endWidth: 0.65,
                                            ),
// Added small height range in bottom to show shadow effect.
                                            GaugeRange(
                                              startValue: 0,
                                              endValue: 99,
                                              color: const Color.fromRGBO(
                                                  155, 155, 155, 0.3),
                                              rangeOffset: 0.5,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              startWidth: 0.15,
                                              endWidth: 0.15,
                                            ),
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: getSleepingValue(snapshot
                                                  .data[index].sleepingHrs),
                                              needleLength: 0.65,
                                              lengthUnit: GaugeSizeUnit.factor,
                                              needleStartWidth: 1,
                                              needleEndWidth: 7,
                                              knobStyle: KnobStyle(
                                                knobRadius: 9,
                                                sizeUnit:
                                                    GaugeSizeUnit.logicalPixel,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center(child: Text('Network error'));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
