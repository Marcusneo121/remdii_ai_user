import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:fyp/components/rounded_password_field.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  final formGlobalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // final ICController = TextEditingController();
  // final add1Controller = TextEditingController();
  // final add2Controller = TextEditingController();
  // final add3Controller = TextEditingController();
  final pwdController = TextEditingController();
  final rePwdController = TextEditingController();
  final OTPController = TextEditingController();
  // late EmailAuth emailAuth;

  bool checkEmail = false;

  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  // String initialValue = 'Gender';
  // var genderList = [
  //   'Gender',
  //   'Male',
  //   'Female',
  //   'Prefer not to say',
  // ];

  // void initState() {
  //   super.initState();
  //   emailAuth = new EmailAuth(sessionName: "OTP Session");
  //
  //   /// Configuring the remote server
  //   emailAuth.config(remoteServerConfiguration);
  // }

  Future userSignUp() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      var result = await conn.query(
          'SELECT * FROM customer WHERE user_email = ?',
          [emailController.text]);
      if (result.isEmpty) {
        var insertResult = await conn.query(
            'insert into customer '
            '(user_name, user_email, user_pwd, user_phone, user_ic, '
            'user_add_1, user_add_2, user_add_3) values (?, ?, ?, ?, ?, ?, ?, ?)',
            [
              nameController.text,
              emailController.text,
              pwdController.text,
              phoneController.text,
              '',
              '',
              '',
              '',
              // ICController.text,
              // add1Controller.text,
              // add2Controller.text,
              // add3Controller.text
            ]);
        var chkResult = await conn.query(
            'SELECT * FROM customer WHERE user_email = ?',
            [emailController.text]);

        for (var row in chkResult) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('userID', row[0]);
          print(prefs.getInt('userID'));
        }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomepageScreen(),
          ),
          (route) => false,
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                  'Email existed in our database. Please sign up with a new email.'),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      await conn.close();
    } catch (e) {
      print(e);
    }
  }

  // void sendOTP() async {
  //   try {
  //     var conn = await MySqlConnection.connect(settings);
  //     var Qresult = await conn.query(
  //         'SELECT * FROM customer WHERE user_email = ?',
  //         [emailController.text]);
  //     if (Qresult.isEmpty) {
  //       var result = await emailAuth.sendOtp(
  //         recipientMail: emailController.value.text,
  //         //recipientMail: 'darkestarzz2@gmail.com',
  //         otpLength: 6,
  //       );
  //
  //       if (result) {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: new Text(
  //                   'One-time password (OTP) has been sent to your email. Please enter the one-time password (OTP) given.'),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   child: new Text("OK"),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: new Text(
  //                   'Fail to send one-time password (OTP) to your email. Please re-enter a valid email address.'),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   child: new Text("OK"),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: new Text(
  //                 'Email existed in our database. Please sign up with a new email.'),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: new Text("OK"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } on Exception catch (e) {
  //     // TODO
  //     print(e);
  //   }
  // }

  // void verifyOTP() {
  //   var result = emailAuth.validateOtp(
  //       recipientMail: emailController.value.text,
  //       userOtp: OTPController.value.text);
  //
  //   if (result) {
  //     print("OTP Verfied");
  //     checkEmail = true;
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: new Text(
  //               'Invalid one-time password (OTP) given. Please re-enter the one-time password (OTP) sent to your email.'),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: new Text("OK"),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.08,
                ),
                RoundedInputField(
                  hintText: "Full Name",
                  icon: Icons.person,
                  onChanged: (value) {},
                  controller: nameController,
                  validator: validateName,
                  enableMode: true,
                ),
                // RoundedInputField(
                //   hintText: "Username",
                //   icon: Icons.person_pin_rounded,
                //   onChanged: (value) {},
                // ),
                RoundedInputField(
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  onChanged: (value) {},
                  controller: emailController,
                  validator: validateEmail,
                  enableMode: true,
                ),
                RoundedInputField(
                  hintText: "Phone Number",
                  icon: Icons.local_phone,
                  onChanged: (value) {},
                  controller: phoneController,
                  validator: validatePhone,
                  enableMode: true,
                ),
                // RoundedInputField(
                //   hintText: "IC Number",
                //   icon: Icons.badge,
                //   onChanged: (value) {},
                //   controller: ICController,
                //   validator: validateIC,
                //   enableMode: true,
                // ),
                // RoundedInputField(
                //   hintText: "Address Line 1",
                //   icon: Icons.location_on,
                //   onChanged: (value) {},
                //   controller: add1Controller,
                //   validator: validateAddress,
                //   enableMode: true,
                // ),
                // RoundedInputField(
                //   hintText: "Address Line 2",
                //   icon: Icons.location_on,
                //   onChanged: (value) {},
                //   controller: add2Controller,
                //   validator: validateAddress,
                //   enableMode: true,
                // ),
                // RoundedInputField(
                //   hintText: "Address Line 3",
                //   icon: Icons.location_on,
                //   onChanged: (value) {},
                //   controller: add3Controller,
                //   validator: validateAddress,
                //   enableMode: true,
                // ),
                RoundedPasswordField(
                  validator: validatePwd,
                  controller: pwdController,
                  onChanged: (value) {},
                  icon: Icons.lock,
                  hintText: "Password",
                ),
                RoundedPasswordField(
                  validator: validateRePwd,
                  controller: rePwdController,
                  onChanged: (value) {},
                  icon: Icons.lock,
                  hintText: "Confirm Password",
                ),

                //This is send OTP
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                //   width: size.width * 0.9,
                //   child: TextFormField(
                //     controller: OTPController,
                //     keyboardType: TextInputType.number,
                //     validator: validateOTP,
                //     maxLength: 6,
                //     decoration: InputDecoration(
                //       hintText: "One-time-password (OTP)",
                //       labelText: "One-time-password (OTP)",
                //       labelStyle: TextStyle(color: hintColor),
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(color: hintColor),
                //       ),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(color: hintColor),
                //       ),
                //       icon: Icon(
                //         FontAwesomeIcons.key,
                //         color: hintColor,
                //       ),
                //       suffixIcon: TextButton(
                //         child: Text(
                //           "Send OTP",
                //           style: TextStyle(
                //             color: buttonColor,
                //           ),
                //         ),
                //         onPressed: () {
                //           print(emailController.value.text);
                //           sendOTP();
                //         },
                //       ),
                //       // border: InputBorder.none,
                //     ),
                //   ),
                // ),
                // Align(
                //     alignment: Alignment(0.02, 1.0),
                //   child: Icon(
                //     Icons.ice_skating
                //   )
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   width: size.width * 0.8,
                //   height: 52,
                //   //gives the height of the dropdown button
                //   //gives the width of the dropdown button
                //   decoration: BoxDecoration(
                //     color: kPrimaryColor,
                //     borderRadius: BorderRadius.circular(29),
                //   ),
                //
                //   padding: const EdgeInsets.only(left: 45, right: 15), //you can include padding to control the menu items
                //   child: Theme(
                //     data: Theme.of(context).copyWith(
                //       canvasColor: kPrimaryColor,
                //       // background color for the dropdown items
                //       buttonTheme: ButtonTheme.of(context).copyWith(
                //         alignedDropdown:
                //             true, //If false (the default), then the dropdown's menu will be wider than its button.
                //       ),
                //     ),
                //     child: DropdownButtonHideUnderline(
                //       // to hide the default underline of the dropdown button
                //       child: DropdownButton<String>(
                //         icon: Icon(
                //           Icons.keyboard_arrow_down,
                //           color: hintColor,
                //         ),
                //         // icon color of the dropdown button
                //         items: genderList.map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(
                //               value,
                //               style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                //             ),
                //           );
                //         }).toList(),
                //         hint: Text(
                //           initialValue,
                //           style:
                //               TextStyle(color: hintColor, fontSize: 15),
                //         ),
                //         // setting hint
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             initialValue = newValue!; // saving the selected value
                //           });
                //         },
                //         value: initialValue, // displaying the selected value
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: size.height * 0.02),
                RoundedButton(
                  text: "Sign Up",
                  press: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
                      await userSignUp();
                      //verifyOTP();
                      // if (checkEmail) {
                      //   await userSignUp();
                      // }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateName(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your name is required";
      return _msg;
    }
    return null;
  }

  String? validateEmail(String? value) {
    String _msg = '';
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value!.isEmpty) {
      _msg = "Your email is required";
      return _msg;
    } else if (!regex.hasMatch(value)) {
      _msg = "Please provide a valid email address";
      emailController.text = '';
      return _msg;
    }
    return null;
  }

  String? validatePhone(String? value) {
    String _msg = '';
    RegExp regex = new RegExp(r'(^01[0-9]{8,9}$)');
    if (value!.isEmpty) {
      _msg = "Your phone number is required";
      return _msg;
    } else if (!regex.hasMatch(value)) {
      _msg =
          "Please provide a valid phone number with \nthe given format (0123456789)";
      phoneController.text = '';
      return _msg;
    }
    return null;
  }

  // String? validateIC(String? value) {
  //   String _msg = '';
  //   RegExp regex = new RegExp(r'(^[0-9]{6}-[0-9]{2}-[0-9]{4}$)');
  //   if (value!.isEmpty) {
  //     _msg = "Your IC number is required";
  //     return _msg;
  //   } else if (!regex.hasMatch(value)) {
  //     _msg =
  //         "Please provide a valid IC number with the format \n(XXXXXX-XX-XXXX)";
  //     ICController.text = '';
  //     return _msg;
  //   }
  //   return null;
  // }
  //
  // String? validateAddress(String? value) {
  //   String _msg = '';
  //   if (value!.isEmpty) {
  //     _msg = "Your address is required";
  //     return _msg;
  //   }
  //   return null;
  // }

  // String? validateAddress3(String? value){
  //   String _msg = '';
  //   if (value!.isEmpty) {
  //     _msg = "Your address is required";
  //     return _msg;
  //   }
  //   return null;
  // }

  String? validatePwd(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your password is required";
      return _msg;
    } else if (value.length <= 7 || value.length >= 13) {
      _msg = "Your password length must be 8-12 characters";
      pwdController.text = '';
      return _msg;
    }
    return null;
  }

  String? validateRePwd(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your password is required";
      return _msg;
    } else if (value != pwdController.text) {
      _msg = "Your repeated password must be same as password";
      rePwdController.text = '';
      return _msg;
    }
    return null;
  }

  String? validateOTP(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your OTP is required";
      return _msg;
    }
    return null;
  }
}

// class Body extends StatelessWidget {
//   // const Body({Key? key}) : super(key: key);
//   var itemList = ['Male', 'Female', 'Prefer not to say'];
//   String initialValue = 'Gender';
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Container(
//           // height: size.height,
//           // width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 "assets/images/logo.png",
//                 height: size.height * 0.08,
//               ),
//               RoundedInputField(
//                 hintText: "Full Name",
//                 icon: Icons.person,
//                 onChanged: (value) {},
//               ),
//               RoundedInputField(
//                 hintText: "Username",
//                 icon: Icons.person_pin_rounded,
//                 onChanged: (value) {},
//               ),
//               RoundedInputField(
//                 hintText: "Email",
//                 icon: Icons.email_outlined,
//                 onChanged: (value) {},
//               ),
//               // DropdownButton<String>(
//               //   isExpanded: true,
//               //   iconEnabledColor: Colors.white,
//               //   style: TextStyle(color: Colors.white, fontSize: 16),
//               //   dropdownColor: Colors.greenAccent,
//               //   focusColor: Colors.black,
//               //   value: initialValue,
//               //
//               //   icon: Icon(Icons.keyboard_arrow_down),
//               //   items: itemList.map((String items){
//               //     return DropdownMenuItem(value: items, child: Text(items));
//               //   }).toList(),
//               //   // onChanged: (String newValue){
//               //   //   setState((){
//               //   //     initialValue = newValue;
//               //   //   });
//               //   // },
//               //   onChanged: (String? newValue) {
//               //     setState(() {
//               //       initialValue = newValue!;
//               //     });
//               //   },
//               // ),
//               // RoundedInputField(
//               //   hintText: "Gender",
//               //   icon: Icons.email_outlined,
//               //   onChanged: (value) {},
//               // ),
//               RoundedInputField(
//                 hintText: "Phone Number",
//                 icon: Icons.local_phone,
//                 onChanged: (value) {},
//               ),
//               RoundedInputField(
//                 hintText: "IC Number",
//                 icon: Icons.badge,
//                 onChanged: (value) {},
//               ),
//               RoundedInputField(
//                 hintText: "Address Line 1",
//                 icon: Icons.location_on,
//                 onChanged: (value) {},
//               ),
//               RoundedInputField(
//                 hintText: "Address Line 2",
//                 icon: Icons.location_on,
//                 onChanged: (value) {},
//               ),
//               RoundedInputField(
//                 hintText: "Address Line 3",
//                 icon: Icons.location_on,
//                 onChanged: (value) {},
//               ),
//               SizedBox(height: size.height * 0.02),
//               RoundedButton(
//                 text: "Sign Up",
//                 press: () {},
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
