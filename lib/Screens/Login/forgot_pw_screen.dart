import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Login/reset_pw_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPWScreen extends StatefulWidget {
  const ForgotPWScreen({Key? key}) : super(key: key);

  @override
  _ForgotPWScreenState createState() => _ForgotPWScreenState();
}

class _ForgotPWScreenState extends State<ForgotPWScreen> {
  final emailController = TextEditingController();
  final ICController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  final OTPController = TextEditingController();
  final EmailAuth emailAuth = new EmailAuth(sessionName: "OTP session");
  bool checkEmail = false;

  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  forgotPW() async {
    var conn = await MySqlConnection.connect(settings);
    try {
      var results = await conn.query(
          'SELECT * FROM customer WHERE user_email = ?',
          [emailController.text]);

      if (results.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:
                  new Text('User not found. Please sign up with new account.'),
              actions: <Widget>[
                ElevatedButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        for (var row in results) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('userID', row[0]);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ResetPWScreen();
            },
          ),
        );
      }
      await conn.close();
    } catch (e) {
      print(e);
    }
  }

  void sendOTP() async {
    try {
      var conn = await MySqlConnection.connect(settings);
      var Qresult = await conn.query(
          'SELECT * FROM customer WHERE user_email = ?',
          [emailController.text]);

      if (Qresult.isNotEmpty) {
        var result = await emailAuth.sendOtp(
          recipientMail: emailController.value.text,
          otpLength: 6,
        );

        if (result) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text(
                    'One-time password (OTP) has been sent to your email. Please enter the one-time password (OTP) given.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text(
                    'Fail to send one-time password (OTP) to your email. Please re-enter a valid email address.'),
                actions: <Widget>[
                  ElevatedButton(
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                  'Email not existed in our database. Please sign up with a new email.'),
              actions: <Widget>[
                ElevatedButton(
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
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void verifyOTP() {
    var result = emailAuth.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: OTPController.value.text);

    if (result) {
      print("OTP Verfied");
      checkEmail = true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
                'Invalid one-time password (OTP) given. Please re-enter the one-time password (OTP) sent to your email.'),
            actions: <Widget>[
              ElevatedButton(
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot Password",
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Forgot your password?",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0)),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Enter your registered email to verify your identity",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RoundedInputField(
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  onChanged: (value) {},
                  validator: validateEmail,
                  controller: emailController,
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  width: size.width * 0.9,
                  child: TextFormField(
                    controller: OTPController,
                    keyboardType: TextInputType.number,
                    validator: validateOTP,
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: "One-time-password (OTP)",
                      labelText: "One-time-password (OTP)",
                      labelStyle: TextStyle(color: hintColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: hintColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: hintColor),
                      ),
                      icon: Icon(
                        FontAwesomeIcons.key,
                        color: hintColor,
                      ),
                      suffixIcon: TextButton(
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        onPressed: () {
                          sendOTP();
                        },
                      ),
                      // border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedButton(
                  text: "Next",
                  press: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
                      verifyOTP();
                      if (checkEmail) {
                        await forgotPW();
                      }
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

  // String? validateIC(String? value) {
  //   String _msg = '';
  //   RegExp regex = new RegExp(r'(^[0-9]{6}-[0-9]{2}-[0-9]{4}$)');
  //   if (value!.isEmpty) {
  //     _msg = "Your IC number is required";
  //     return _msg;
  //   } else if (!regex.hasMatch(value)) {
  //     _msg =
  //     "Please provide a valid IC number with the format \n(XXXXXX-XX-XXXX)";
  //     ICController.text = '';
  //     return _msg;
  //   }
  //   return null;
  // }

  String? validateOTP(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your OTP is required";
      return _msg;
    }
    return null;
  }
}
