import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/CaseDetails.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen.dart';
import 'package:fyp/Screens/EczemaInfo/eczema_info_screen_after_ai_result.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_button_outline.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ViewAIResultScreen extends StatefulWidget {
  const ViewAIResultScreen({Key? key, required this.nextID}) : super(key: key);
  final int nextID;

  @override
  _ViewAIResultScreenState createState() => _ViewAIResultScreenState();
}

class _ViewAIResultScreenState extends State<ViewAIResultScreen> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = fetchCaseData();
    super.initState();
  }

  fetchCaseData() async {
    try {
      List<CaseDetails> caseDetails = [];
      var conn = await MySqlConnection.connect(settings);
      var results = await conn.query(
          'SELECT caseID, detailID, caseImg, date, time, result, severity, status, comments '
          'FROM casedetails '
          'WHERE detailID = ? ',
          [widget.nextID]);
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
            comments: row[8],
            foodLog: '',
            sleepTime: '',
            wakeTime: '',
            sleepingHrs: 0,
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
      EasyLoading.showSuccess(
          'Your request has been sent. Kindly wait for consultant to feedback. Thank you!');
      await conn.close();
      return caseDetails;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Result Detected",
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
                return Container(
                  width: double.infinity,
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.memory(
                            base64.decode(snapshot.data[0].caseImg),
                            fit: BoxFit.fill,
                            width: 300.0,
                            height: 200.0,
                          ),
                          SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Diagnosis Date: ${snapshot.data[0].date}',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Diagnosis Time: ${snapshot.data[0].time}',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          //Initial Version Code
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Result: ${snapshot.data[0].result}',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          ),
                          //Dummy Code
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Result : -',
                          //     style: TextStyle(
                          //         fontFamily: 'Lato',
                          //         fontWeight: FontWeight.w800,
                          //         fontSize: 18.0),
                          //   ),
                          // ),
                          SizedBox(height: 10.0),
                          //Initial Version Code
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Severity: ${snapshot.data[0].severity}',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          ),
                          //Dummy Code
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Severity : -',
                          //     style: TextStyle(
                          //         fontFamily: 'Lato',
                          //         fontWeight: FontWeight.w800,
                          //         fontSize: 18.0),
                          //   ),
                          // ),
                          SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Consultant's Comment : Pending",
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          //Initial Version
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     '${snapshot.data[0].comments}',
                          //     textAlign: TextAlign.justify,
                          //     style: TextStyle(
                          //         fontFamily: 'Lato',
                          //         fontWeight: FontWeight.w800,
                          //         fontSize: 18.0),
                          //   ),
                          // ),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Pending review',
                          //     textAlign: TextAlign.justify,
                          //     style: TextStyle(
                          //         fontFamily: 'Lato',
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 15.0),
                          //   ),
                          // ),
                          SizedBox(height: 30.0),
                          RoundedButton(
                              text: "To Eczema Info Screen",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ViewInfoScreenAfterResult();
                                    },
                                  ),
                                );
                              }),
                          RoundedOutlinedButton(
                              text: "Back to Home",
                              press: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        //HomepageScreen(),
                                        Homepage(),
                                  ),
                                  (route) => false,
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Center(child: Text('Network Error'));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
