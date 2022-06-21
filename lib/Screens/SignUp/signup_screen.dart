import 'package:flutter/material.dart';
import 'package:fyp/Screens/SignUp/Components/body.dart';
import 'package:fyp/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign Up",
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: 22.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: BodyPage());
  }
}
