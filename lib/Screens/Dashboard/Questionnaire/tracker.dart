import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp/Screens/Dashboard/Questionnaire/foodSurvey.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int selectedValueQ1 = 5;
  int selectedValueQ2 = 5;
  int selectedValueQ3 = 5;
  int selectedValueQ4 = 5;
  int selectedValueQ5 = 5;
  int selectedValueQ6 = 5;
  int selectedValueQ7 = 5;

  ExpandableController q1ExpandableController = ExpandableController();
  ExpandableController q2ExpandableController = ExpandableController();
  ExpandableController q3ExpandableController = ExpandableController();
  ExpandableController q4ExpandableController = ExpandableController();
  ExpandableController q5ExpandableController = ExpandableController();
  ExpandableController q6ExpandableController = ExpandableController();
  ExpandableController q7ExpandableController = ExpandableController();

  int poemScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Eczema Tracker",
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Column(
                children: [
                  ExpandablePanel(
                    controller: q1ExpandableController,
                    header: Text(
                      "1. Over the last week, on how many days has your/your child’s skin been itchy because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ1,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ1 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q1ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ1,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ1 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q1ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ1,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ1 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q1ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ1,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ1 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q1ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ1,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ1 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q1ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  ExpandablePanel(
                    controller: q2ExpandableController,
                    header: Text(
                      "2. Over the last week, on how many nights has your/your child’s sleep been disturbed because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ2,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ2 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q2ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ2,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ2 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q2ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ2,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ2 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q2ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ2,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ2 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q2ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ2,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ2 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q2ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  ExpandablePanel(
                    controller: q3ExpandableController,
                    header: Text(
                      "3. Over the last week, on how many days has your/your child’s skin been bleeding because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ3,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ3 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q3ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ3,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ3 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q3ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ3,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ3 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q3ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ3,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ3 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q3ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ3,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ3 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q3ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  ExpandablePanel(
                    controller: q4ExpandableController,
                    header: Text(
                      "4. Over the last week, on how many days has your/your child’s skin been weeping or oozing clear fluid because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ4,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ4 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q4ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ4,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ4 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q4ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ4,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ4 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q4ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ4,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ4 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q4ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ4,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ4 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q4ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  ExpandablePanel(
                    controller: q5ExpandableController,
                    header: Text(
                      "5. Over the last week, on how many days has your/your child’s skin been cracked because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ5,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ5 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q5ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ5,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ5 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q5ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ5,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ5 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q5ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ5,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ5 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q5ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ5,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ5 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q5ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  ExpandablePanel(
                    controller: q6ExpandableController,
                    header: Text(
                      "6. Over the last week, on how many days has your/your child’s skin been flaking off because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ6,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ6 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q6ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ6,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ6 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q6ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ6,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ6 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q6ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ6,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ6 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q6ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ6,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ6 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q6ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  ExpandablePanel(
                    controller: q7ExpandableController,
                    header: Text(
                      "7. Over the last week, on how many days has your/your child’s skin felt dry or rough because of the eczema?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                    expanded: Container(),
                    collapsed: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: selectedValueQ7,
                          title: Text("No days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ7 = 0;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q7ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: selectedValueQ7,
                          title: Text("1 - 2 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ7 = 1;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q7ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: selectedValueQ7,
                          title: Text("3 - 4 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ7 = 2;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q7ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: selectedValueQ7,
                          title: Text("5 - 6 days"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ7 = 3;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q7ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                        RadioListTile(
                          activeColor: buttonColor,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: selectedValueQ7,
                          title: Text("Everyday"),
                          onChanged: (value) {
                            setState(() {
                              selectedValueQ7 = 4;
                              Future.delayed(Duration(milliseconds: 500), () {
                                q7ExpandableController.toggle();
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    // the horizontal line
                    color: Colors.grey[900],
                    height: 30,
                  ),
                ],
              ),
              RoundedButton(
                text: "Submit",
                press: () async {
                  if (selectedValueQ1 == 5 ||
                      selectedValueQ2 == 5 ||
                      selectedValueQ3 == 5 ||
                      selectedValueQ4 == 5 ||
                      selectedValueQ5 == 5 ||
                      selectedValueQ6 == 5 ||
                      selectedValueQ7 == 5) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text(
                              'Please ensure all questions are answered before submit.'),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                              ),
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    setState(() {
                      poemScore = selectedValueQ1 +
                          selectedValueQ2 +
                          selectedValueQ3 +
                          selectedValueQ4 +
                          selectedValueQ5 +
                          selectedValueQ6 +
                          selectedValueQ7;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('poemScore', poemScore.toString());

                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return FoodSurveyScreen();
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
