import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool enableMode;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.controller,
    required this.validator,
    required this.enableMode,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.9,
      child: TextFormField(
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        enabled: enableMode,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: hintColor),
          labelText: enableMode? hintText: 'You are not allowed to edit the email',
          icon: Icon(
            icon,
            color: hintColor,
          ),
          hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hintColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:  hintColor),
          ),
        ),
      ),
    );
  }
}