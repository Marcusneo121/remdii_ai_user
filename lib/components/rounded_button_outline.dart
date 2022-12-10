import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;

  const RoundedOutlinedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = buttonColor,
    this.textColor = const Color(0xFF42995C),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.8,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // background (button) color
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: color,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(29),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: textColor),
          )),
    );
  }
}
