import 'dart:convert';
import 'package:fyp/LocalNotifyManager.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/view_and_update_screen.dart';
import 'package:fyp/Screens/EczemaDiagnosis/Components/view_AI_result_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/DB_Models/connection.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    print('Notification Received: ${notification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload: $payload');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ViewUpdate();
        },
      ),
    );
  }

  final formGlobalKey = GlobalKey<FormState>();
  String? message;
  String? result;
  String? severity;

  detectResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? q1 = prefs.getString('q1');
    String? q2 = prefs.getString('q2');
    String? q3 = prefs.getString('q3');
    String? q4 = prefs.getString('q4');
    String? q5 = prefs.getString('q5');
    String? q6 = prefs.getString('q6');
    print(q1);
    if (q1 == 'Yes') {
      q1 = "1";
    } else if (q1 == 'No') {
      q1 = "0";
    }
    if (q2 == 'Yes') {
      q2 = "1";
    } else if (q2 == 'No') {
      q2 = "0";
    }
    if (q3 == 'Yes') {
      q3 = "1";
    } else if (q3 == 'No') {
      q3 = "0";
    }
    if (q4 == 'Yes') {
      q4 = "1";
    } else if (q4 == 'No') {
      q4 = "0";
    }
    if (q5 == 'Yes') {
      q5 = "1";
    } else if (q5 == 'No') {
      q5 = "0";
    }
    if (q6 == 'Yes') {
      q6 = "1";
    } else if (q6 == 'No') {
      q6 = "0";
    }

    String? question = q1! + q2! + q3! + q4! + q5! + q6!;
    print(question);

    //Upload Questionnaire
    // final url = 'http://i2hub.tarc.edu.my:8850/app';
    final url = 'http://34.124.249.17:8850/app';
    final responseQues = await http.post(Uri.parse(url),
        body: json.encode({'question': question}));
    print('1');

    //Get Questionnaire Answer
    final response_get = await http.get(Uri.parse(url));
    final decoded = json.decode(response_get.body) as Map<String, dynamic>;
    message = decoded['question'];
    print('message returned');
    print(message);
    print('2');

    if (message == "Severe_Eczema") {
      result = "Eczema";
      severity = "Severe";
    } else if (message == "Moderate_Eczema") {
      result = "Eczema";
      severity = "Moderate";
    } else if (message == "Mild_Eczema") {
      result = "Eczema";
      severity = "Mild";
    } else {
      result = "Not eczema";
      severity = "No";
    }
    print('result: $result');
    print('severity: $severity');
    print('3');
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Eczema Diagnosis",
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.w800, fontSize: 22.0),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Instructions: \n- Please answer the following questions for diagnosis purpose.",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '1. Dry and itchy skin? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_1",
                  onChanged: (value) async {
                    print(value);
                    print('Storing pref for q1');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('q1', value as String);
                    print('Checked!!');
                    print(prefs.getString('q1'));
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value1) => FormBuilderFieldOption(
                            value: value1,
                            child: Text(
                              value1,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '2. Weeping/oozing? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_2",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) async {
                    print(value);
                    print('Storing pref for q2');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('q2', value as String);
                    print('Checked!!');
                    print(prefs.getString('q2'));
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value2) => FormBuilderFieldOption(
                            value: value2,
                            child: Text(
                              value2,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '3. Raw skin? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_3",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) async {
                    print(value);
                    print('Storing pref for q3');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('q3', value as String);
                    print('Checked!!');
                    print(prefs.getString('q3'));
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value3) => FormBuilderFieldOption(
                            value: value3,
                            child: Text(
                              value3,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '4. Any infection? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_4",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) async {
                    print(value);
                    print('Storing pref for q4');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('q4', value as String);
                    print('Checked!!');
                    print(prefs.getString('q4'));
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value4) => FormBuilderFieldOption(
                            value: value4,
                            child: Text(
                              value4,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '5. Long term steroid user? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_5",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) async {
                    print(value);
                    print('Storing pref for q5');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('q5', value as String);
                    print('Checked!!');
                    print(prefs.getString('q5'));
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value5) => FormBuilderFieldOption(
                            value: value5,
                            child: Text(
                              value5,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '6. On medication? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_6",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) async {
                    print(value);
                    print('Storing pref for q6');
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('q6', value as String);
                    print('Checked!!');
                    print(prefs.getString('q6'));
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value6) => FormBuilderFieldOption(
                            value: value6,
                            child: Text(
                              value6,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RoundedButton(
                            text: "Continue",
                            color: buttonColor,
                            press: () {
                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Disclaimer Message'),
                                    content: const Text(
                                        'This tool does not provide medical advice. It is intended for informational purposes only. It is not a substitute for professional medical advice, diagnosis or treatment.'),
                                    actions: <Widget>[
                                      TextButton(
                                          child: const Text('OK'),
                                          onPressed: () async {
                                            detectResult();
                                            print('ok');

                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            var settings =
                                                new ConnectionSettings(
                                              host: connection.host,
                                              port: connection.port,
                                              user: connection.user,
                                              password: connection.pw,
                                              db: connection.db,
                                            );
                                            var conn =
                                                await MySqlConnection.connect(
                                                    settings);

                                            int nextID = -1;
                                            var checkID = await conn.query(
                                                'SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = "remdii_db" AND TABLE_NAME = "casedetails"');
                                            for (var row in checkID) {
                                              nextID = row[0];
                                            }
                                            // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

                                            // await localNotifyManager
                                            //     .scheduleNotification();

                                            // print(prefs.getStringList('bodyPart')!.join(","));
                                            await conn.query(
                                                'INSERT INTO casehistory (body, q1, q2, q3, q4, q5, q6, user_id) '
                                                'VALUE (?, ?, ?, ?, ?, ?, ?, ?)',
                                                [
                                                  prefs
                                                      .getStringList(
                                                          'bodyPart')!
                                                      .join(", "),
                                                  prefs.getString('q1'),
                                                  prefs.getString('q2'),
                                                  prefs.getString('q3'),
                                                  prefs.getString('q4'),
                                                  prefs.getString('q5'),
                                                  prefs.getString('q6'),
                                                  prefs.getInt('userID'),
                                                  // id,
                                                ]);
                                            var results = await conn.query(
                                                'SELECT caseID FROM casehistory WHERE user_id = ? '
                                                'ORDER BY caseID DESC LIMIT 1',
                                                [prefs.getInt('userID')]);
                                            print(results);
                                            int? _caseID;
                                            for (var row in results) {
                                              _caseID = row[0];
                                            }

                                            var now = new DateTime.now();
                                            var date =
                                                new DateFormat('dd/MM/yyyy');
                                            String formattedDate =
                                                date.format(now);
                                            var time = new DateFormat.jm();
                                            String formattedTime =
                                                time.format(now);
                                            await conn.query(
                                                'INSERT INTO casedetails (caseImg, date, time, caseID, status, comments, sleepingHrs, result, severity, reviewStatus) '
                                                'VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                                                [
                                                  prefs.getString('caseImg'),
                                                  formattedDate,
                                                  formattedTime,
                                                  _caseID,
                                                  'Not Verified',
                                                  '-',
                                                  0,
                                                  'Will be reviewed by consultant.',
                                                  'Will be reviewed by consultant.',
                                                  // result.toString(),
                                                  // severity.toString(),
                                                  'Unassigned',
                                                ]);

                                            await conn.close();
                                            await prefs.remove('caseImg');
                                            await prefs.remove('bodyPart');
                                            await prefs.remove('q1');
                                            await prefs.remove('q2');
                                            await prefs.remove('q3');
                                            await prefs.remove('q4');
                                            await prefs.remove('q5');
                                            await prefs.remove('q6');
                                            print(prefs.getString('caseImg'));
                                            print(prefs
                                                .getStringList('bodyPart'));
                                            print(prefs.getString('q1'));
                                            print(prefs.getString('q2'));
                                            print(prefs.getString('q3'));
                                            print(prefs.getString('q4'));
                                            print(prefs.getString('q5'));
                                            print(prefs.getString('q6'));

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ViewAIResultScreen(
                                                    nextID: nextID,
                                                  );
                                                },
                                              ),
                                            );
                                            // Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                );
                              }
                            })),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
