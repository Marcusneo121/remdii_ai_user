import 'package:flutter/material.dart';
import 'package:fyp/Screens/Login/login_screen.dart';
import 'package:fyp/Screens/SignUp/signup_screen.dart';
import 'package:fyp/components/rounded_button.dart';
import 'package:fyp/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO",
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 25.0),
            ),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.25,
            ),
            RoundedButton(
              text: "SIGN IN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: buttonColor2,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
