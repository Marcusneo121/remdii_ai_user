import 'package:flutter/material.dart';
import 'package:fyp/components/rounded_input_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       RoundedInputField(
      //         hintText: "Full Name",
      //         icon: Icons.person,
      //         onChanged: (value) {},
      //       ),
      //     ]
      // ),
    );
  }
}
