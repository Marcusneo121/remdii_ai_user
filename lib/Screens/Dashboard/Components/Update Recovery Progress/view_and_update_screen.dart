import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/CaseDetails.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/view_result_screen.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewUpdate extends StatefulWidget {
  const ViewUpdate({Key? key}) : super(key: key);

  @override
  _ViewUpdateState createState() => _ViewUpdateState();
}

class _ViewUpdateState extends State<ViewUpdate> {
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);
  late Future _future;

  @override
  void initState() {
    _future = fetchCaseData();
    // splitImg();
    super.initState();
  }

  fetchCaseData() async {
    try {
      // List<Case> caseList = [];
      List<CaseDetails> caseDetails = [];
      int prevID = -1;
      var conn = await MySqlConnection.connect(settings);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var detailResults = await conn.query(
          'SELECT casehistory.caseID, detailID, caseImg, '
          'date, time, result, severity, status, comments '
          'FROM casehistory, casedetails '
          'WHERE casehistory.caseID = casedetails.caseID  '
          'AND user_id = ? '
          'ORDER BY casedetails.caseID ASC',
          [prefs.getInt('userID')]);
      for (var row in detailResults) {
        // print(row[0].runtimeType);
        // print(row[1].runtimeType);
        // print(row[2].runtimeType);
        // print(row[3].runtimeType);
        // print(row[4].runtimeType);
        // print(row[5].runtimeType);
        // print(row[6].runtimeType);
        // print(row[7].runtimeType);
        // print(row[8].runtimeType);
        if (prevID != row[0]) {
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
            q4Ans: '',
          ));
          prevID = row[0];
        }
      }
      print('detailResults');
      print(detailResults);
      print(caseDetails);
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
        title: Text(
          "View and Update",
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
              if (snapshot.data.isEmpty) {
                return Center(
                    child: Text('Your diagnosis history is empty now.'));
              } else {
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 110.0,
                                height: 100.0,
                                child: Image.memory(
                                  // '${diagnose_img[index]}',
                                  base64.decode(snapshot.data[index].caseImg),
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
                                    'Date: ${snapshot.data[index].date}',
                                    style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    'Result: ${snapshot.data[index].result}',
                                    style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16.0),
                                  ),
                                  SizedBox(
                                    height: 35.0,
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
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 52.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setInt(
                                      'caseID', snapshot.data[index].caseID);
                                  print('Storing caseID');
                                  print(prefs.getInt('caseID'));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ViewResult(
                                          caseDetails: snapshot.data[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      buttonColor, // background (button) color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
