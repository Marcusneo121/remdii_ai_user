import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/sleeping_analysis_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_button_outline.dart';
import 'package:fyp/constants.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateSleepTimeScreen extends StatefulWidget {
  const UpdateSleepTimeScreen({Key? key}) : super(key: key);

  @override
  _UpdateSleepTimeScreenState createState() => _UpdateSleepTimeScreenState();
}

class _UpdateSleepTimeScreenState extends State<UpdateSleepTimeScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Recovery Progress",
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
              children: [
                Text(
                  "Instructions: \n- Please enter your sleeping time and wake up time for diagnosis purpose.",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: FractionalOffset.centerLeft,
                  child: FormBuilderDateTimePicker(
                    name: "date",
                    inputType: InputType.date,
                    format: DateFormat("dd/MM/yyyy"),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 1),
                    selectableDayPredicate: _decideWhichDayToEnable,
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.calendarAlt,
                          color: Color(0xFF6C6C6C), size: 22.0),
                      labelText: "Select Date",
                      labelStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6C6C6C),
                          fontSize: 16.0),
                    ),
                    validator: FormBuilderValidators.required(context,
                        errorText: 'Your input is required'),
                    onChanged: (value) async {
                      print(DateFormat("dd/MM/yyyy").format(value!));
                      print('Storing pref for date');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      //prefs.setString('date', DateFormat("dd/MM/yyyy").format(value).toString());
                      prefs.setString('date', value.toString());
                      print('Checked!!');
                      print(prefs.getString('date'));
                      // print(DateTime.parse(prefs.getString('date')!));
                      // var hello = DateTime.parse(prefs.getString('date')!);
                      // print(DateFormat.Hm().format(hello));
                    },
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   alignment: FractionalOffset.centerLeft,
                //   child: RaisedButton(
                //     color: Color(0xFFDEDEDE),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(29.0),
                //     ),
                //     padding:
                //         EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                //     elevation: 0.0,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //         Icon(FontAwesomeIcons.solidMoon,
                //             color: Color(0xFF6C6C6C), size: 17.0),
                //         SizedBox(
                //           width: 25.0,
                //         ),
                //         Text(
                //           getText1(),
                //           style: TextStyle(
                //               fontFamily: 'Lato',
                //               fontWeight: FontWeight.w800,
                //               color: Color(0xFF6C6C6C),
                //               fontSize: 16.0),
                //         ),
                //       ],
                //     ),
                //     onPressed: _selectTime1,
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   alignment: FractionalOffset.centerLeft,
                //   child: RaisedButton(
                //     color: Color(0xFFDEDEDE),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(29.0),
                //     ),
                //     padding:
                //     EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                //     elevation: 0.0,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //         Icon(FontAwesomeIcons.solidSun,
                //             color: Color(0xFF6C6C6C), size: 17.0),
                //         SizedBox(
                //           width: 25.0,
                //         ),
                //         Text(
                //           getText2(),
                //           style: TextStyle(
                //               fontFamily: 'Lato',
                //               fontWeight: FontWeight.w800,
                //               color: Color(0xFF6C6C6C),
                //               fontSize: 16.0),
                //         ),
                //       ],
                //     ),
                //     onPressed: _selectTime2,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: FractionalOffset.centerLeft,
                  child: FormBuilderDateTimePicker(
                    name: 'sleep_time',
                    inputType: InputType.time,
                    format: DateFormat.Hm(),
                    alwaysUse24HourFormat: true,
                    initialTime: TimeOfDay(hour: 23, minute: 0),
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.solidMoon,
                          color: Color(0xFF6C6C6C), size: 22.0),
                      labelText: "Select Sleeping Time",
                      labelStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6C6C6C),
                          fontSize: 16.0),
                    ),
                    validator: FormBuilderValidators.required(context,
                        errorText: 'Your input is required'),
                    onChanged: (value) async {
                      print(DateFormat.Hm().format(value!));
                      print('Storing pref for sleepTime');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // prefs.setString('sleepTime', DateFormat.Hm().format(value).toString());
                      prefs.setString('sleepTime', value.toString());
                      print('Checked!!');
                      print(prefs.getString('sleepTime'));
                      // print(DateTime.parse(prefs.getString('sleepTime')!));
                      // var hello = DateTime.parse(prefs.getString('sleepTime')!);
                      // print(DateFormat.Hm().format(hello));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: FractionalOffset.centerLeft,
                  child: FormBuilderDateTimePicker(
                    name: 'wake_up_time',
                    inputType: InputType.time,
                    format: DateFormat.Hm(),
                    alwaysUse24HourFormat: true,
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.solidSun,
                          color: Color(0xFF6C6C6C), size: 22.0),
                      labelText: "Select Wake Up Time",
                      labelStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6C6C6C),
                          fontSize: 16.0),
                    ),
                    validator: FormBuilderValidators.required(context,
                        errorText: 'Your input is required'),
                    onChanged: (value) async {
                      print(DateFormat.Hm().format(value!));
                      print('Storing pref for wakeTime');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // prefs.setString('wakeTime', DateFormat.Hm().format(value).toString());
                      prefs.setString('wakeTime', value.toString());
                      print('Checked!!');
                      print(prefs.getString('wakeTime'));
                      // print(DateTime.parse(prefs.getString('wakeTime')!));
                      // var hello = DateTime.parse(prefs.getString('wakeTime')!);
                      // print(DateFormat.Hm().format(hello));
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                    text: "Continue",
                    color: buttonColor,
                    press: () async {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SleepingAnalysisScreen();
                            },
                          ),
                        );
                      }
                    }),
                RoundedOutlinedButton(
                    text: "Skip",
                    press: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('date', '');
                      prefs.setString('sleepTime', '');
                      prefs.setString('wakeTime', '');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SleepingAnalysisScreen();
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 5))) &&
        day.isBefore(DateTime.now().add(Duration(days: 0))))) {
      return true;
    }
    return false;
  }
}
