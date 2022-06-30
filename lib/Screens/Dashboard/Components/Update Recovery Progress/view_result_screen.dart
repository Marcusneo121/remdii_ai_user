import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/CaseDetails.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/update_photo_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/view_detail_report_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';

class ViewResult extends StatefulWidget {
  const ViewResult({
    Key? key,
    required this.caseDetails,
  }) : super(key: key);
  final CaseDetails caseDetails;
  @override
  _ViewResultState createState() => _ViewResultState();
}

class _ViewResultState extends State<ViewResult> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Case",
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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.memory(
                  base64.decode(widget.caseDetails.caseImg),
                  fit: BoxFit.fill,
                  width: 300.0,
                  height: 200.0,
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Diagnosis Date: ${widget.caseDetails.date}",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Diagnosis Time: ${widget.caseDetails.time}",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Result:",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " ${widget.caseDetails.result}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Severity:",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.caseDetails.severity}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Consultant's Comment: ",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.caseDetails.comments}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 20.0),
                RoundedButton(
                  text: "Update Recovery Progress",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdatePhotoScreen();
                        },
                      ),
                    );
                  },
                ),
                RoundedButton(
                  color: buttonColor2,
                  text: "View Detail Progress Report",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewReportScreen(
                            caseID: widget.caseDetails.caseID,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
