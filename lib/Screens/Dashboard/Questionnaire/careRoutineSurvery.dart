import 'dart:convert';
import 'package:fyp/DB_Models/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Models/surveyModel/care_routine_survey_model.dart';
import 'package:fyp/Models/surveyModel/contact_allergens_survey_model.dart';
import 'package:fyp/Models/surveyModel/environment_survey_model.dart';
import 'package:fyp/Models/surveyModel/food_survey_model.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CareRoutineSurveyScreen extends StatefulWidget {
  const CareRoutineSurveyScreen({super.key});

  @override
  State<CareRoutineSurveyScreen> createState() =>
      _CareRoutineSurveyScreenState();
}

class _CareRoutineSurveyScreenState extends State<CareRoutineSurveyScreen> {
  bool moisturiser = false;
  bool topicalSteroids = false;
  bool medicines = false;
  bool immunosuppressant = false;
  bool wetWrapTherapy = false;
  bool bleachBath = false;

  late ContactAllergensSurveyModel contactAllergenSurveyModel;
  late CareRoutineSurveyModel careRoutineSurveyModel;
  late EnvironmentSurveyModel environmentSurveyModel;
  late FoodSurveyModel foodSurveyModel;
  late String poemScore;

  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDayMonthYearGetter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Care Routine",
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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "Please select care routine you had done in the past week.",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text(
                        "Moisturiser",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: moisturiser,
                      onChanged: (value) {
                        setState(() {
                          moisturiser = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Topical Steroids",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: topicalSteroids,
                      onChanged: (value) {
                        setState(() {
                          topicalSteroids = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Medicines",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: medicines,
                      onChanged: (value) {
                        setState(() {
                          medicines = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Immunosuppressant",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: immunosuppressant,
                      onChanged: (value) {
                        setState(() {
                          immunosuppressant = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Wet Wrap Therapy",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: wetWrapTherapy,
                      onChanged: (value) {
                        setState(() {
                          wetWrapTherapy = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Bleach bath",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: bleachBath,
                      onChanged: (value) {
                        setState(() {
                          bleachBath = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              RoundedButton(
                text: "Submit",
                press: () async {
                  var careRoutineSurveyJSON = {
                    "Moisturiser": moisturiser,
                    "TopicalSteroids": topicalSteroids,
                    "Medicines": medicines,
                    "Immunosuppressant": immunosuppressant,
                    "WetWrapTherapy": wetWrapTherapy,
                    "BleachBath": bleachBath,
                  };

                  String careRoutineSurveyString =
                      json.encode(careRoutineSurveyJSON);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString(
                      'careRoutineSurveyJSON', careRoutineSurveyString);

                  await insertRadarChartData();

                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) => HomepageScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  currentDayMonthYearGetter() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    final dateTimeSplitter = formattedDate.split('-');
    print(dateTimeSplitter[0]);
    print(dateTimeSplitter[1]);
    print(dateTimeSplitter[2]);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (int.parse(dateTimeSplitter[2]) <= 7) {
      prefs.setString('currentWeek', '1');
    } else if (int.parse(dateTimeSplitter[2]) > 7 &&
        int.parse(dateTimeSplitter[2]) <= 14) {
      prefs.setString('currentWeek', '2');
    } else if (int.parse(dateTimeSplitter[2]) > 14 &&
        int.parse(dateTimeSplitter[2]) <= 21) {
      prefs.setString('currentWeek', '3');
    } else if (int.parse(dateTimeSplitter[2]) > 21) {
      prefs.setString('currentWeek', '4');
    }

    prefs.setString('currentDay', dateTimeSplitter[2]);
    prefs.setString('currentMonth', dateTimeSplitter[1]);
    prefs.setString('currentYear', dateTimeSplitter[0]);

    print(prefs.getString('currentWeek'));
  }

  insertRadarChartData() async {
    var conn = await MySqlConnection.connect(settings);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime nowTime = DateTime.now();

    await getAllSurveyData(prefs);

    var checkSameRecordResult = await conn.query(
      'SELECT * FROM radarChartData WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
      [
        prefs.getInt('userID'),
        prefs.getString('currentWeek').toString(),
        prefs.getString('currentMonth').toString(),
        prefs.getString('currentYear').toString(),
      ],
    );

    if (checkSameRecordResult.isEmpty) {
      //Continue add new record

      //insert new data into RadarChartData Table
      await conn.query(
        'INSERT INTO radarChartData'
        '(publishedAt, user_id, month, week, year,'
        'egg, cowMilk, soy, peanut, seafood, wheat, '
        'dust, sun, sweat, pets,'
        'fragrance, rubber, nickel, formaldehyde, preservatives, sanitizer, '
        'moisturizer, steroids, medicines, immunosuppressant, wetWrapTherapy, bleachBath) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          nowTime.toUtc(),
          prefs.getInt('userID'),
          prefs.getString('currentMonth').toString(),
          prefs.getString('currentWeek').toString(),
          prefs.getString('currentYear').toString(),
          foodSurveyModel.egg == true ? 1 : 0,
          foodSurveyModel.cowMilk == true ? 1 : 0,
          foodSurveyModel.soy == true ? 1 : 0,
          foodSurveyModel.peanut == true ? 1 : 0,
          foodSurveyModel.seafood == true ? 1 : 0,
          foodSurveyModel.wheat == true ? 1 : 0,
          environmentSurveyModel.dust == true ? 1 : 0,
          environmentSurveyModel.sun == true ? 1 : 0,
          environmentSurveyModel.sweat == true ? 1 : 0,
          environmentSurveyModel.pets == true ? 1 : 0,
          contactAllergenSurveyModel.fragrance == true ? 1 : 0,
          contactAllergenSurveyModel.rubber == true ? 1 : 0,
          contactAllergenSurveyModel.nickel == true ? 1 : 0,
          contactAllergenSurveyModel.formaldehyde == true ? 1 : 0,
          contactAllergenSurveyModel.preservatives == true ? 1 : 0,
          contactAllergenSurveyModel.sanitiser == true ? 1 : 0,
          careRoutineSurveyModel.moisturiser == true ? 1 : 0,
          careRoutineSurveyModel.topicalSteroids == true ? 1 : 0,
          careRoutineSurveyModel.medicines == true ? 1 : 0,
          careRoutineSurveyModel.immunosuppressant == true ? 1 : 0,
          careRoutineSurveyModel.wetWrapTherapy == true ? 1 : 0,
          careRoutineSurveyModel.bleachBath == true ? 1 : 0,
        ],
      );

      await insertRadarChart(conn, prefs);
      await insertLineChart(conn, prefs);
    } else {
      //Update Record
      await conn.query(
        'UPDATE radarChartData SET publishedAt = ?,'
        'egg = ? , cowMilk = ? , soy = ? , peanut = ? , seafood = ? , wheat = ? , '
        'dust = ? , sun = ? , sweat = ? , pets = ? ,'
        'fragrance = ? , rubber = ? , nickel = ? , formaldehyde = ? , preservatives = ?, sanitizer = ? ,'
        'moisturizer = ? , steroids = ? , medicines = ? , immunosuppressant = ? , wetWrapTherapy = ? , bleachBath = ? '
        'WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
        [
          nowTime.toUtc(),
          foodSurveyModel.egg == true ? 1 : 0,
          foodSurveyModel.cowMilk == true ? 1 : 0,
          foodSurveyModel.soy == true ? 1 : 0,
          foodSurveyModel.peanut == true ? 1 : 0,
          foodSurveyModel.seafood == true ? 1 : 0,
          foodSurveyModel.wheat == true ? 1 : 0,
          environmentSurveyModel.dust == true ? 1 : 0,
          environmentSurveyModel.sun == true ? 1 : 0,
          environmentSurveyModel.sweat == true ? 1 : 0,
          environmentSurveyModel.pets == true ? 1 : 0,
          contactAllergenSurveyModel.fragrance == true ? 1 : 0,
          contactAllergenSurveyModel.rubber == true ? 1 : 0,
          contactAllergenSurveyModel.nickel == true ? 1 : 0,
          contactAllergenSurveyModel.formaldehyde == true ? 1 : 0,
          contactAllergenSurveyModel.preservatives == true ? 1 : 0,
          contactAllergenSurveyModel.sanitiser == true ? 1 : 0,
          careRoutineSurveyModel.moisturiser == true ? 1 : 0,
          careRoutineSurveyModel.topicalSteroids == true ? 1 : 0,
          careRoutineSurveyModel.medicines == true ? 1 : 0,
          careRoutineSurveyModel.immunosuppressant == true ? 1 : 0,
          careRoutineSurveyModel.wetWrapTherapy == true ? 1 : 0,
          careRoutineSurveyModel.bleachBath == true ? 1 : 0,
          prefs.getInt('userID'),
          prefs.getString('currentWeek').toString(),
          prefs.getString('currentMonth').toString(),
          prefs.getString('currentYear').toString(),
        ],
      );

      await updateRadarChart(conn, prefs);
      await updateLineChart(conn, prefs);
    }

    await conn.close();
  }

  insertRadarChart(var conn, SharedPreferences prefs) async {
    var getRadarChartDataResult = await conn.query(
      'SELECT * FROM radarChartData WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
      [
        prefs.getInt('userID'),
        prefs.getString('currentWeek').toString(),
        prefs.getString('currentMonth').toString(),
        prefs.getString('currentYear').toString(),
      ],
    );

    print(getRadarChartDataResult.toString());

    for (var row in getRadarChartDataResult) {
      await conn.query(
        'INSERT INTO radarChart'
        '(publishedAt, user_id, month, week, year, radarChartDataID)'
        'VALUES (?, ?, ?, ?, ?, ?)',
        [
          row[2],
          row[1],
          row[25].toString(),
          row[26].toString(),
          row[27].toString(),
          row[0],
        ],
      );
    }
  }

  updateRadarChart(var conn, SharedPreferences prefs) async {
    var getRadarChartDataResult = await conn.query(
      'SELECT * FROM radarChartData WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
      [
        prefs.getInt('userID'),
        prefs.getString('currentWeek').toString(),
        prefs.getString('currentMonth').toString(),
        prefs.getString('currentYear').toString(),
      ],
    );

    for (var row in getRadarChartDataResult) {
      await conn.query(
        'UPDATE radarChart SET '
        'publishedAt = ? '
        'WHERE user_id = ? AND month = ? AND week = ? AND year = ? AND radarChartDataID = ?',
        [
          row[2],
          row[1],
          row[25].toString(),
          row[26].toString(),
          row[27].toString(),
          row[0],
        ],
      );
    }
  }

  insertLineChart(var conn, SharedPreferences prefs) async {
    var getRadarChartResult = await conn.query(
      'SELECT * FROM radarChart WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
      [
        prefs.getInt('userID'),
        prefs.getString('currentWeek').toString(),
        prefs.getString('currentMonth').toString(),
        prefs.getString('currentYear').toString(),
      ],
    );

    print(getRadarChartResult.toString());

    late int eczemaLevel;

    if (int.parse(poemScore) >= 0 && int.parse(poemScore) <= 2) {
      eczemaLevel = 0;
    } else if (int.parse(poemScore) >= 3 && int.parse(poemScore) <= 7) {
      eczemaLevel = 1;
    } else if (int.parse(poemScore) >= 8 && int.parse(poemScore) <= 16) {
      eczemaLevel = 2;
    } else if (int.parse(poemScore) >= 17 && int.parse(poemScore) <= 24) {
      eczemaLevel = 3;
    } else if (int.parse(poemScore) >= 25 && int.parse(poemScore) <= 28) {
      eczemaLevel = 4;
    } else if (int.parse(poemScore) >= 29 && int.parse(poemScore) <= 31) {
      eczemaLevel = 4;
    }

    for (var row in getRadarChartResult) {
      await conn.query(
        'INSERT INTO lineChart'
        '(weekLevel, poem, publishedAt, user_id, month, week, year, radarChartID)'
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          eczemaLevel,
          int.parse(poemScore),
          row[1],
          row[2],
          row[3].toString(),
          row[4].toString(),
          row[5].toString(),
          row[0],
        ],
      );
    }
  }

  updateLineChart(var conn, SharedPreferences prefs) async {
    var getRadarChartResult = await conn.query(
      'SELECT * FROM radarChart WHERE user_id = ? AND week = ? AND month = ? AND year = ?',
      [
        prefs.getInt('userID'),
        prefs.getString('currentWeek').toString(),
        prefs.getString('currentMonth').toString(),
        prefs.getString('currentYear').toString(),
      ],
    );

    print(getRadarChartResult.toString());

    late int eczemaLevel;

    if (int.parse(poemScore) >= 0 && int.parse(poemScore) <= 2) {
      eczemaLevel = 0;
    } else if (int.parse(poemScore) >= 3 && int.parse(poemScore) <= 7) {
      eczemaLevel = 1;
    } else if (int.parse(poemScore) >= 8 && int.parse(poemScore) <= 16) {
      eczemaLevel = 2;
    } else if (int.parse(poemScore) >= 17 && int.parse(poemScore) <= 24) {
      eczemaLevel = 3;
    } else if (int.parse(poemScore) >= 25 && int.parse(poemScore) <= 28) {
      eczemaLevel = 4;
    }

    for (var row in getRadarChartResult) {
      await conn.query(
        'UPDATE lineChart SET '
        'weekLevel = ?, poem = ?, publishedAt = ? '
        'WHERE user_id = ? AND month = ? AND week = ? AND year = ? AND radarChartID = ?',
        [
          eczemaLevel,
          int.parse(poemScore),
          row[1],
          row[2],
          row[3],
          row[4],
          row[5],
          row[0],
        ],
      );
    }
  }

  getAllSurveyData(SharedPreferences prefs) {
    String? localPoem = prefs.getString('poemScore');

    poemScore = localPoem!;

    //Food Input Start
    String? localFoodSurveyString = prefs.getString('foodSurveyJSON');

    foodSurveyModel =
        FoodSurveyModel.fromJson(json.decode(localFoodSurveyString.toString()));
    //Food Input End

    //Environment Input Start
    String? localEnvironmentSurveyString =
        prefs.getString('environmentSurveyJSON');

    environmentSurveyModel = EnvironmentSurveyModel.fromJson(
        json.decode(localEnvironmentSurveyString.toString()));
    //Environment Input End

    //Contact Allergens Input Start
    String? localContactAllergenSurveyString =
        prefs.getString('contactAllergenSurveyJSON');

    contactAllergenSurveyModel = ContactAllergensSurveyModel.fromJson(
        json.decode(localContactAllergenSurveyString.toString()));
    //Contact Allergens Input End

    //Care Routine Input Start
    String? localCareRoutineSurveyString =
        prefs.getString('careRoutineSurveyJSON');

    careRoutineSurveyModel = CareRoutineSurveyModel.fromJson(
        json.decode(localCareRoutineSurveyString.toString()));
    //Care Routine Input End
  }
}
