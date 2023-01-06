import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Models/surveyModel/contact_allergens_survey_model.dart';
import 'package:fyp/Screens/Dashboard/Questionnaire/careRoutineSurvery.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactAllergenSurveyScreen extends StatefulWidget {
  const ContactAllergenSurveyScreen({super.key});

  @override
  State<ContactAllergenSurveyScreen> createState() =>
      _ContactAllergenSurveyScreenState();
}

class _ContactAllergenSurveyScreenState
    extends State<ContactAllergenSurveyScreen> {
  bool fragrance = false;
  bool rubber = false;
  bool nickel = false;
  bool formaldehyde = false;
  bool preservatives = false;
  bool sanitiser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Allergens",
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
                      "Please select materials that you had contacted in the past week.",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    CheckboxListTile(
                      title: Text(
                        "Fragrance",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: fragrance,
                      onChanged: (value) {
                        setState(() {
                          fragrance = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Rubber",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: rubber,
                      onChanged: (value) {
                        setState(() {
                          rubber = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Nickel",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: nickel,
                      onChanged: (value) {
                        setState(() {
                          nickel = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Formaldehyde",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: formaldehyde,
                      onChanged: (value) {
                        setState(() {
                          formaldehyde = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Preservatives",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: preservatives,
                      onChanged: (value) {
                        setState(() {
                          preservatives = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        "Sanitiser",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                      activeColor: buttonColor,
                      value: sanitiser,
                      onChanged: (value) {
                        setState(() {
                          sanitiser = value!;
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
                  var contactAllergenSurveyJSON = {
                    'Fragrance': fragrance,
                    'Rubber': rubber,
                    'Nickel': nickel,
                    'Formaldehyde': formaldehyde,
                    'Preservatives': preservatives,
                    'Sanitiser': sanitiser,
                  };

                  String contactAllergenSurveyString =
                      json.encode(contactAllergenSurveyJSON);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString(
                      'contactAllergenSurveyJSON', contactAllergenSurveyString);

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return CareRoutineSurveyScreen();
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
