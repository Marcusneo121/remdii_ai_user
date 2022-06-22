import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/food_diary_screen.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateQuestionnaireScreen extends StatefulWidget {
  const UpdateQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _UpdateQuestionnaireScreenState createState() =>
      _UpdateQuestionnaireScreenState();
}

class _UpdateQuestionnaireScreenState extends State<UpdateQuestionnaireScreen> {
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isVisible4 = false;
  final q1Controller = TextEditingController();
  final q2Controller = TextEditingController();
  final q3Controller = TextEditingController();
  final q4Controller = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  var q1, q2, q3, q4;
  // var q1Ans, q2Ans, q3Ans, q4Ans;

  @override
  void initState() {
    // TODO: implement initState
    // isVisible1 = false;
    // checkRadio();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Instructions: \n- Please answer the following questions for diagnosis purpose.",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '1. Have you applied moisturisers today? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_1",
                  onChanged: (value) {
                    if (value == "Yes") {
                      setState(() {
                        isVisible1 = true;
                        q1 = value;
                      });
                    } else {
                      setState(() {
                        isVisible1 = false;
                        q1 = value;
                      });
                    }
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value1) => FormBuilderFieldOption(
                            value: value1,
                            child: Text(
                              value1,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isVisible1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // maxLines: 4,
                    // maxLength: 100,
                    controller: q1Controller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                          color: Colors.black),
                      hintText: ' How many times you apply the moisturiser?',
                      labelText: ' How many times you apply the moisturiser?',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Your answer is required ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //Update Flares

                // FormBuilderRadioGroup(
                //   validator: FormBuilderValidators.required(context, errorText: 'Your answer is required'),
                //   activeColor: buttonColor,
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.all(10),
                //     labelText: '2. Are you having flares up today? \*',
                //     border: OutlineInputBorder(),
                //     // filled: true,
                //     labelStyle: TextStyle(
                //         fontFamily: 'Lato',
                //         fontWeight: FontWeight.w800,
                //         fontSize: 20.0,
                //         color: Colors.black),
                //   ),
                //   name: "question_2",
                //   // validator: FormBuilderValidators.required(context),
                //   onChanged: (value) {
                //     if (value == "Yes") {
                //       setState(() {
                //         isVisible2 = true;
                //         q2 = value;
                //       });
                //     } else {
                //       setState(() {
                //         isVisible2 = false;
                //         q2 = value;
                //       });
                //     }
                //   },
                //   options: [
                //     "Yes",
                //     "No",
                //   ]
                //       .map((value2) => FormBuilderFieldOption(
                //             value: value2,
                //             child: Text(
                //               value2,
                //             ),
                //           ))
                //       .toList(growable: false),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Visibility(
                //   visible: isVisible2,
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     // maxLines: 4,
                //     // maxLength: 100,
                //     controller: q2Controller,
                //     decoration: const InputDecoration(
                //       labelStyle: TextStyle(
                //           fontFamily: 'Lato',
                //           fontWeight: FontWeight.w800,
                //           fontSize: 16.0,
                //           color: Colors.black),
                //       hintText: ' How many times you having flares?',
                //       labelText: ' How many times you having flares?',
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: buttonColor,
                //           width: 2.0,
                //         ),
                //       ),
                //     ),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Your answer is required ';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '3. Did you take any medicine today? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_3",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) {
                    if (value == "Yes") {
                      setState(() {
                        isVisible3 = true;
                        q3 = value;
                      });
                    } else {
                      setState(() {
                        isVisible3 = false;
                        q3 = value;
                      });
                    }
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value3) => FormBuilderFieldOption(
                            value: value3,
                            child: Text(
                              value3,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isVisible3,
                  child: TextFormField(
                    // keyboardType: TextInputType.number,
                    // maxLines: 4,
                    // maxLength: 100,
                    controller: q3Controller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                          color: Colors.black),
                      hintText: ' What medicine you have taken?',
                      labelText: ' What medicine you have taken?',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Your answer is required ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(context,
                      errorText: 'Your answer is required'),
                  activeColor: buttonColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '4. Did you apply steroid today? \*',
                    border: OutlineInputBorder(),
                    // filled: true,
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: Colors.black),
                  ),
                  name: "question_4",
                  // validator: FormBuilderValidators.required(context),
                  onChanged: (value) {
                    if (value == "Yes") {
                      setState(() {
                        isVisible4 = true;
                        q4 = value;
                      });
                    } else {
                      setState(() {
                        isVisible4 = false;
                        q4 = value;
                      });
                    }
                  },
                  options: [
                    "Yes",
                    "No",
                  ]
                      .map((value4) => FormBuilderFieldOption(
                            value: value4,
                            child: Text(
                              value4,
                            ),
                          ))
                      .toList(growable: false),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isVisible4,
                  child: TextFormField(
                    // keyboardType: TextInputType.number,
                    // maxLines: 4,
                    // maxLength: 100,
                    controller: q4Controller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                          color: Colors.black),
                      hintText: ' What steroid you have taken?',
                      labelText: ' What steroid you have taken?',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Your answer is required ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RoundedButton(
                          text: "Continue",
                          color: buttonColor,
                          press: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('q1', q1);
                              if (q1 == "Yes") {
                                prefs.setString('q1Ans', q1Controller.text);
                              } else {
                                prefs.setString('q1Ans', '-');
                              }
                              print('Checked!!');
                              print(prefs.getString('q1'));
                              print(prefs.getString('q1Ans'));

                              // prefs.setString('q2', q2);
                              // if (q2 == "Yes") {
                              //   prefs.setString('q2Ans', q2Controller.text);
                              // } else {
                              //   prefs.setString('q2Ans', '-');
                              // }
                              // print('Checked!!');
                              // print(prefs.getString('q2'));
                              // print(prefs.getString('q2Ans'));

                              prefs.setString('q3', q3);
                              if (q3 == "Yes") {
                                prefs.setString('q3Ans', q3Controller.text);
                              } else {
                                prefs.setString('q3Ans', '-');
                              }
                              print('Checked!!');
                              print(prefs.getString('q3'));
                              print(prefs.getString('q3Ans'));

                              prefs.setString('q4', q4);
                              if (q4 == "Yes") {
                                prefs.setString('q4Ans', q4Controller.text);
                              } else {
                                prefs.setString('q4Ans', '-');
                              }
                              print('Checked!!');
                              print(prefs.getString('q4'));
                              print(prefs.getString('q4Ans'));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FoodDiaryScreen();
                                  },
                                ),
                              );

                              // print(q1);
                              // print(q1Controller.text);
                              // print(q2);
                              // print(q2Controller.text);
                              // print(q3);
                              // print(q3Controller.text);
                              // print(q4);
                              // print(q4Controller.text);
                            }
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // String? validateRadio(String? value) {
  //   String _msg = '';
  //   if (value!.isEmpty) {
  //     _msg = "Your answer is required";
  //     return _msg;
  //   }
  //   return null;
  // }
}
