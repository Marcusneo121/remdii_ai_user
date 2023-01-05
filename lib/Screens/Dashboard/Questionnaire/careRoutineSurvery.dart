import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Models/surveyModel/care_routine_survey_model.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
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
                  prefs.setString(
                      'careRoutineSurveyJSON', careRoutineSurveyString);

                  String? localCareRoutineSurveyString =
                      prefs.getString('contactAllergenSurveyJSON');

                  CareRoutineSurveyModel careRoutineSurveyModel =
                      CareRoutineSurveyModel.fromJson(
                          json.decode(localCareRoutineSurveyString.toString()));

                  print(careRoutineSurveyModel.bleachBath.toString());

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
}
