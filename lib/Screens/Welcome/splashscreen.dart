import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/Screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:mysql1/mysql1.dart';

class Splashscreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    getStayLogin();
  }

  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  Future userLogin(String userInputEmail, String userInputPassword) async {
    String userEmail = userInputEmail;
    String userPwd = userInputPassword;
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
            EasyLoading.dismiss();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text(
                      'Invalid password entered. Please provide a valid password.'),
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
      } else if (results.length == 0) {
        print('Email does not exist in database.');
        EasyLoading.dismiss();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                  'Email does not exist. Please create a new account.'),
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
      await conn.close();
    } catch (e) {
      print(e);
    }
  }

  Future getStayLogin() async {
    final SharedPreferences stayLoginShared =
        await SharedPreferences.getInstance();
    final obtainedEmail = stayLoginShared.getString('userInputEmail');
    final obtainedPassword = stayLoginShared.getString('userInputPassword');
    // setState(() {
    //   finalEmail = obtainedEmail;
    //   finalPassword = obtainedPassword;
    // });
    if (obtainedEmail == null && obtainedPassword == null) {
      Future.delayed(Duration(seconds: 4)).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => WelcomeScreen(),
          ),
          (route) => false,
        );
      });
    } else {
      userLogin(obtainedEmail!, obtainedPassword!);
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Obx(() {
          //   return (Get.find<AuthController>().user != null) ? Home() : Login();
          // }),
          Spacer(),
          Hero(
            tag: 'logo',
            child: Container(
              width: 400,
              height: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          //SizedBox(height: 32),
          // Text(
          //   'Car for everyone.',
          //   style: TextStyle(
          //     color: Color(0xFF7879F1),
          //     fontFamily: 'Poppins',
          //     fontSize: 20,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          Spacer(),
        ],
      ),
    );
  }
}
