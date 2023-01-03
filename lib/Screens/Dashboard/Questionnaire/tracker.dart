import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int selectedValueQ1 = 5;
  int selectedValueQ2 = 5;
  int selectedValueQ3 = 5;

  ExpandableController q1ExpandableController = ExpandableController();
  ExpandableController q2ExpandableController = ExpandableController();
  ExpandableController q3ExpandableController = ExpandableController();

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
              RoundedButton(
                text: "Submit",
                press: () async {
                  if (selectedValueQ1 == 5 ||
                      selectedValueQ2 == 5 ||
                      selectedValueQ3 == 5) {
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
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  radioButtonGroup(int selectedValue) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        RadioListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          value: 0,
          groupValue: selectedValue,
          title: Text("No days"),
          onChanged: (value) {
            setState(() {
              selectedValue = 0;
            });
          },
        ),
        RadioListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          value: 1,
          groupValue: selectedValue,
          title: Text("1 - 2 days"),
          onChanged: (value) {
            setState(() {
              selectedValue = 1;
            });
          },
        ),
        RadioListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          value: 2,
          groupValue: selectedValue,
          title: Text("3 - 4 days"),
          onChanged: (value) {
            setState(() {
              selectedValue = 2;
            });
          },
        ),
        RadioListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          value: 3,
          groupValue: selectedValue,
          title: Text("5 - 6 days"),
          onChanged: (value) {
            setState(() {
              selectedValue = 3;
            });
          },
        ),
        RadioListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          value: 4,
          groupValue: selectedValue,
          title: Text("Everyday"),
          onChanged: (value) {
            setState(() {
              selectedValue = 4;
            });
          },
        ),
      ],
    );
  }
}
