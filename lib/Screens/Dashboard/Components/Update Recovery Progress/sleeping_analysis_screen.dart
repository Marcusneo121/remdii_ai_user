import 'package:flutter/material.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/update_result_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/DB_Models/connection.dart';

class SleepingAnalysisScreen extends StatefulWidget {
  const SleepingAnalysisScreen({Key? key}) : super(key: key);

  @override
  _SleepingAnalysisScreenState createState() => _SleepingAnalysisScreenState();
}

class _SleepingAnalysisScreenState extends State<SleepingAnalysisScreen> {
  var date, sleepTime, wakeUpTime, duration, star, status;
  late Future _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = getTime();
    super.initState();
  }

  getTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // date = prefs.getString('date');
    // date = DateTime.parse(date);
    // sleepTime = DateTime.parse(prefs.getString('sleepTime')!);
    // wakeUpTime = DateTime.parse(prefs.getString('wakeTime')!);

    date = prefs.getString('date') != ''
        ? prefs.getString('date')
        : DateTime.now().toString();
    date =
        prefs.getString('date') != '' ? DateTime.parse(date) : DateTime.now();
    sleepTime = prefs.getString('sleepTime') != ''
        ? DateTime.parse(prefs.getString('sleepTime')!)
        : DateTime.parse('2022-06-22 00:00:00.000');
    wakeUpTime = prefs.getString('sleepTime') != ''
        ? DateTime.parse(prefs.getString('wakeTime')!)
        : DateTime.parse('2022-06-22 00:00:00.000');
    // print(date.runtimeType);
    // print(sleepTime.runtimeType);

    print(date);
    print(sleepTime);
    print(wakeUpTime);
    var diff;
    if (wakeUpTime.isBefore(sleepTime)) {
      diff = wakeUpTime.add(const Duration(hours: 24)).difference(sleepTime);
    } else
      diff = wakeUpTime.difference(sleepTime);
    print(diff.runtimeType);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(diff.inMinutes.remainder(60));

    duration = "${twoDigits(diff.inHours)} hours $twoDigitMinutes minutes";
    int hour = int.parse(twoDigits(diff.inHours));
    print(hour);
    if (hour == 0) {
      star = 0;
      status = "Skipped";
    } else if (hour < 5) {
      star = 1;
      status = "Bad";
    } else if (hour < 7) {
      star = 3;
      status = "Average";
    } else {
      star = 5;
      status = "Good";
    }
    prefs.setInt('sHour', hour);
    // print("a" + dif.add(const Duration(hours: 24)));
    // date = DateFormat("dd/MM/yyyy").format(date);
    // DateTime dt = DateTime.parse(date);
    // DateTime sleep = DateTime.parse(sleepTime);
    // DateTime wake = DateTime.parse(wakeUpTime);
    // print(dt.runtimeType);
    // print(sleep.runtimeType);
    // print(wake);
    return 'haha';
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = new DateFormat('dd/MM/yyyy');
    var timeFormat = new DateFormat('hh:mm');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Recovery Progress",
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
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: size.height,
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Sleeping Analysis",
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Date: ",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            dateFormat.format(date).toString(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Sleeping Time: ",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            // DateFormat.Hm().format(sleepTime).toString(),
                            timeFormat.format(sleepTime).toString(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Wake Up Time: ",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            // DateFormat.Hm().format(wakeUpTime).toString(),
                            timeFormat.format(wakeUpTime).toString(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Sleeping Hours: ",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            duration.toString(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Sleeping Rating: ",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "$star \u{2B50} ($status)",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                          text: "Continue",
                          color: buttonColor,
                          press: () async {
                            var settings = new ConnectionSettings(
                                host: connection.host,
                                port: connection.port,
                                user: connection.user,
                                password: connection.pw,
                                db: connection.db);
                            var conn = await MySqlConnection.connect(settings);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var now = new DateTime.now();
                            var date = new DateFormat('dd/MM/yyyy');
                            String formattedDate = date.format(now);
                            var time = new DateFormat.jm();
                            String formattedTime = time.format(now);

                            int nextID = -1;
                            var checkID = await conn.query(
                                'SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = "remdii_db" AND TABLE_NAME = "casedetails"');
                            for (var row in checkID) {
                              nextID = row[0];
                            }

                            var results = await conn.query(
                                'SELECT caseID FROM casehistory WHERE user_id = ? '
                                'ORDER BY caseID DESC LIMIT 1',
                                [prefs.getInt('userID')]);
                            print(results);
                            int? _caseID;
                            for (var row in results) {
                              _caseID = row[0];
                            }

                            await conn.query(
                                'INSERT INTO casedetails (caseImg, date, time, foodLog, otherFood,'
                                'wakeUpTime, sleepTime, sleepingHrs, q1, q1Ans, q2, q2Ans, q3, q3Ans, '
                                'q4, q4Ans, status, comments, caseID, result, severity, reviewStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                                [
                                  prefs.getString('caseImg'),
                                  formattedDate,
                                  formattedTime,
                                  prefs.getStringList('foodLog')!.join(", "),
                                  prefs.getString('otherFood'),
                                  DateFormat.Hm().format(
                                      prefs.getString('sleepTime') != ''
                                          ? DateTime.parse(
                                              prefs.getString('sleepTime')!)
                                          : DateTime.parse(
                                              '2022-06-22 00:00:00.000')),
                                  DateFormat.Hm().format(
                                      prefs.getString('sleepTime') != ''
                                          ? DateTime.parse(
                                              prefs.getString('wakeTime')!)
                                          : DateTime.parse(
                                              '2022-06-22 00:00:00.000')),
                                  // DateFormat.Hm().format(DateTime.parse(
                                  //     prefs.getString('sleepTime')!)),
                                  // DateFormat.Hm().format(DateTime.parse(
                                  //     prefs.getString('wakeTime')!)),
                                  prefs.getInt('sHour'),
                                  prefs.getString('q1'),
                                  prefs.getString('q1Ans'),
                                  prefs.getString('q2'),
                                  prefs.getString('q2Ans'),
                                  prefs.getString('q3'),
                                  prefs.getString('q3Ans'),
                                  prefs.getString('q4'),
                                  prefs.getString('q4Ans'),
                                  'Pending',
                                  '-',
                                  prefs.getInt('caseID'),
                                  'Will be further verified soon by consultant ...',
                                  'Will be further verified soon by consultant ...',
                                  'Unassigned',
                                ]);
                            await conn.close();

                            prefs.remove('caseImg');
                            prefs.remove('foodLog');
                            prefs.remove('sleepTime');
                            prefs.remove('wakeTime');
                            prefs.remove('sHour');
                            prefs.remove('q1');
                            prefs.remove('q1Ans');
                            prefs.remove('q2');
                            prefs.remove('q3');
                            prefs.remove('q3Ans');
                            prefs.remove('q4');
                            prefs.remove('q4Ans');
                            prefs.remove('caseID');

                            print(prefs.getString('caseImg'));
                            print(prefs.getStringList('foodLog'));
                            print(prefs.getString('sleepTime'));
                            print(prefs.getString('wakeTime'));
                            print(prefs.getString('q1'));
                            print(prefs.getString('q1Ans'));
                            print(prefs.getString('q2'));
                            print(prefs.getString('q2Ans'));
                            print(prefs.getString('q3'));
                            print(prefs.getString('q3Ans'));
                            print(prefs.getString('q4'));
                            print(prefs.getString('q4Ans'));
                            print(prefs.getString('caseID'));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UpdateResultScreen(
                                    nextID: nextID,
                                  );
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return Center();
            }
          }),
    );
  }
}
