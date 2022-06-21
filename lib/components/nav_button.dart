import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';

class nav_button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;

  const nav_button({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: press,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: hintColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}