import 'package:flutter/material.dart';
import 'package:fyp/Screens/Homepage/homepage_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/components/rounded_password_field.dart';
import 'package:mysql1/mysql1.dart';
import 'package:fyp/DB_Models/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePWScreen extends StatefulWidget {
  const ChangePWScreen({Key? key}) : super(key: key);

  @override
  _ChangePWScreenState createState() => _ChangePWScreenState();
}

class _ChangePWScreenState extends State<ChangePWScreen> {
  final oldPwdController = TextEditingController();
  final pwdController = TextEditingController();
  final rePwdController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  var settings = new ConnectionSettings(
      host: connection.host,
      port: connection.port,
      user: connection.user,
      password: connection.pw,
      db: connection.db);

  changePW() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var conn = await MySqlConnection.connect(settings);
      print(prefs.getInt('userID'));

      if(prefs.getInt('userID') != null){
        String oldPW = '';
        var readPW = await conn.query('SELECT user_pwd FROM customer WHERE user_id = ?', [prefs.getInt('userID')]);
        for(var row in readPW){
          oldPW = row[0].toString();
        }
        if(oldPW == oldPwdController.text){
          var results = await conn.query(
              'UPDATE customer SET user_pwd = ? WHERE user_id = ? ' ,
              [pwdController.text, prefs.getInt('userID').toString()]);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text(
                    'Your passwords have been changed.'),
                actions: <Widget>[
                  FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomepageScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text(
                    'Your old password is incorrect'),
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
      await conn.close();
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change Password",
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
                Text("Change your password?",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0)),
                SizedBox(
                  height: 40,
                ),
                // Text(
                //   "Enter your registered email below to receive\n password reset instruction",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontFamily: 'Lato',
                //     fontWeight: FontWeight.w800,
                //     fontSize: 16,
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                RoundedPasswordField(
                  validator: validateOldPwd,
                  controller: oldPwdController,
                  onChanged: (value) {},
                  icon: Icons.lock,
                  hintText: "Old Password",
                ),
                RoundedPasswordField(
                  validator: validatePwd,
                  controller: pwdController,
                  onChanged: (value) {},
                  icon: Icons.lock,
                  hintText: "New Password",
                ),
                RoundedPasswordField(
                  validator: validateRePwd,
                  controller: rePwdController,
                  onChanged: (value) {},
                  icon: Icons.lock,
                  hintText: "Repeat New Password",
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedButton(
                  text: "Change Password",
                  press: () async{
                    if (formGlobalKey.currentState!.validate()) {
                      formGlobalKey.currentState!.save();
                      await changePW();
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

  String? validateOldPwd(String? value) {
    String _msg = '';
    if (value!.isEmpty) {
      _msg = "Your password is required";
      return _msg;
    }

    return null;
  }

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
      _msg = "Your repeated password \nmust be same as password";
      rePwdController.text = '';
      return _msg;
    }
    return null;
  }
}
