import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Models/surveyModel/environment_survey_model.dart';
import 'package:fyp/Models/surveyModel/food_survey_model.dart';
import 'package:fyp/Screens/Dashboard/Questionnaire/contactAllergensSurvey.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnvironmentSurveyScreen extends StatefulWidget {
  const EnvironmentSurveyScreen({super.key});

  @override
  State<EnvironmentSurveyScreen> createState() =>
      _EnvironmentSurveyScreenState();
}

class _EnvironmentSurveyScreenState extends State<EnvironmentSurveyScreen> {
  bool dust = false;
  bool sun = false;
  bool sweat = false;
  bool pets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Environment",
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
                      "Please select environment you had been through in the past week.",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text(
                        "Dust",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: dust,
                      onChanged: (value) {
                        setState(() {
                          dust = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Sun",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: sun,
                      onChanged: (value) {
                        setState(() {
                          sun = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Sweat",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: sweat,
                      onChanged: (value) {
                        setState(() {
                          sweat = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Pets",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: pets,
                      onChanged: (value) {
                        setState(() {
                          pets = value!;
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
                  var environmentSurveyJSON = {
                    'Dust': dust,
                    'Sun': sun,
                    'Sweat': sweat,
                    'Pets': pets,
                  };

                  String environmentSurveyString =
                      json.encode(environmentSurveyJSON);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(
                      'environmentSurveyJSON', environmentSurveyString);

                  String? localEnvironmentSurveyString =
                      prefs.getString('environmentSurveyJSON');

                  EnvironmentSurveyModel environmentSurveyModel =
                      EnvironmentSurveyModel.fromJson(
                          json.decode(localEnvironmentSurveyString.toString()));

                  print(environmentSurveyModel.dust.toString());

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return ContactAllergenSurveyScreen();
                      },
                    ),
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
