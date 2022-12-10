import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/CaseDetails.dart';
import 'package:fyp/Screens/Chat/AllChat/chatWithStaff.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/update_photo_screen.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/view_detail_report_screen.dart';
import 'package:fyp/Screens/Products/products.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Services/database.dart';

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
  String chatRoomID = "", messageID = "";
  String myAvatarName = "", myEmail = "", myUsername = "", myProfilePic = "";
  late int myID;

  getChatRoomIdByUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getMyInfoFromSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myID = pref.getInt('userID')!;
    myAvatarName =
        pref.getString('userInputEmail')!.replaceAll("@gmail.com", "");
    myUsername = pref.getString('userUsername')!;
    myProfilePic = pref.getString('userImg')!;
    //myEmail = pref.getString('adminEmail')!;
    setState(() {});
  }

  void initState() {
    getMyInfoFromSharedPreference();
    super.initState();
  }

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
                  width: 280.0,
                  height: 190.0,
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
                SizedBox(height: 12.0),
                Container(
                  width: size.width * 0.8,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // background (button) color
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: buttonColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Our Products",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.5,
                            color: buttonColor),
                      )),
                ),
                Container(
                  width: size.width * 0.8,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // background (button) color
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: buttonColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                      ),
                      onPressed: () {
                        var chatRoomID =
                            getChatRoomIdByUsername("admin1", myAvatarName);

                        Map<String, dynamic> chatRoomInfoMap = {
                          "users": [
                            myID,
                            myUsername,
                            myAvatarName,
                            myProfilePic,
                            0,
                            "admin1"
                            // myID,
                            // myUsername
                          ]
                        };

                        DatabaseMethods()
                            .createChatRoom(chatRoomID, chatRoomInfoMap);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return ChatScreenWithStaff(
                              chatWithName: "REMDII Staff",
                              chatWithUsername: "admin1",
                              chatWithUserID: 0,
                            );
                          }),
                        );
                      },
                      child: Text(
                        "Chat With Us",
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.5,
                            color: buttonColor),
                      )),
                ),
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
