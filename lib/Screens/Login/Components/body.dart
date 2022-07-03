import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/Screens/Login/forgot_pw_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_input_field.dart';
import 'package:fyp/components/rounded_password_field.dart';
import 'package:fyp/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formGlobalKey = GlobalKey<FormState>();
  bool visible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  Future userLogin() async {
    setState(() {
      visible = true;
    });
    String userEmail = emailController.text;
    String userPwd = passwordController.text;
    String imageToSave = '';

    try {
      ByteData bytes =
          await rootBundle.load('assets/images/defaultProfile.jpg');
      var buffer = bytes.buffer;
      String image = base64.encode(Uint8List.view(buffer));

      print(image);

      EasyLoading.show(status: 'Logging in...');
      var conn = await MySqlConnection.connect(settings);
      var results = await conn
          .query('SELECT * FROM customer WHERE user_email = ?', [userEmail]);

      if (results.length == 1) {
        for (var row in results) {
          if (userPwd == row[3].toString()) {
            print("Login successful");
            //shared preference here
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt('userID', row[0]);
            print(prefs.getInt('userID'));
            print('Storing pref for img');
            prefs.setString('userInputEmail', emailController.text.toString());
            prefs.setString(
                'userInputPassword', passwordController.text.toString());
            print(prefs.getString('userInputEmail'));
            print(prefs.getString('userInputPassword'));

            if (row[9] != null) {
              setState(() {
                imageToSave = row[9].toString();
              });
            } else {
              setState(() {
                imageToSave = image;
              });
            }
            prefs.setString('userImg', imageToSave);
            print(prefs.getString('userImg'));
            setState(() {
              visible = false;
            });
            EasyLoading.dismiss();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomepageScreen(),
              ),
              (route) => false,
            );
          } else if (userPwd != row[3].toString()) {
            print("Wrong password");
            setState(() {
              visible = false;
            });
            EasyLoading.dismiss();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text(
                      'Invalid password entered. Please provide a valid password.'),
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
        }
      } else if (results.length == 0) {
        print('Email does not exist in database.');
        setState(() {
          visible = false;
        });
        EasyLoading.dismiss();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                  'Email does not exist. Please create a new account.'),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Form(
          key: formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.17,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 30.0),
              ),
              SizedBox(height: size.height * 0.05),
              RoundedInputField(
                validator: validateEmail,
                hintText: "Email",
                icon: Icons.email_outlined,
                onChanged: (value) {},
                controller: emailController,
                enableMode: true,
              ),
              RoundedPasswordField(
                validator: validatePwd,
                controller: passwordController,
                onChanged: (value) {},
                icon: Icons.lock,
                hintText: "Password",
              ),
              Container(
                child: Align(
                  alignment: Alignment(0.70, -0.80),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ForgotPWScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 15.0,
                        decoration: TextDecoration.underline,
                        color: buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.15),
              RoundedButton(
                text: "Sign In",
                //press: validateEmail(emailController.text.trim()).isEmpty && validatePwd(passwordController.text.trim()).isEmpty? userLogin: () {}
                press: () async {
                  if (formGlobalKey.currentState!.validate()) {
                    formGlobalKey.currentState!.save();
                    await userLogin();
                  }
                },
              )
            ],
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
      return _msg;
    }
    return null;
  }

  String? validatePwd(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your password is required";
      return _msg;
    }
    return null;
  }
}
