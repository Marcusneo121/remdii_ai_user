import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Models/surveyModel/food_survey_model.dart';
import 'package:fyp/Screens/Dashboard/Questionnaire/environmentSurvey.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodSurveyScreen extends StatefulWidget {
  const FoodSurveyScreen({super.key});

  @override
  State<FoodSurveyScreen> createState() => _FoodSurveyScreenState();
}

class _FoodSurveyScreenState extends State<FoodSurveyScreen> {
  bool egg = false;
  bool cowMilk = false;
  bool soy = false;
  bool peanut = false;
  bool seafood = false;
  bool wheat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Food",
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
                      "Please select food that you have eaten in the past week.",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text(
                        "Egg",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: egg,
                      onChanged: (value) {
                        setState(() {
                          egg = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Cow's Milk",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: cowMilk,
                      onChanged: (value) {
                        setState(() {
                          cowMilk = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Soy",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: soy,
                      onChanged: (value) {
                        setState(() {
                          soy = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Peanut",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: peanut,
                      onChanged: (value) {
                        setState(() {
                          peanut = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Seafood",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: seafood,
                      onChanged: (value) {
                        setState(() {
                          seafood = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Wheat/Gluten",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: wheat,
                      onChanged: (value) {
                        setState(() {
                          wheat = value!;
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
                  var foodSurveyJSON = {
                    'Egg': egg,
                    'CowMilk': cowMilk,
                    'Soy': soy,
                    'Peanut': peanut,
                    'Seafood': seafood,
                    'Wheat': wheat,
                  };

                  String foodSurveyString = json.encode(foodSurveyJSON);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('foodSurveyJSON', foodSurveyString);

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return EnvironmentSurveyScreen();
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
