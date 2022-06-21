import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';

class PretypedRoundedInputField extends StatelessWidget {
  const PretypedRoundedInputField({
    Key? key,
    required this.initialValue,
    required this.icon,
    required this.onChanged,
    required this.validator,
    required this.hintText,
    required this.enableMode,
  }) : super(key: key);

  final String initialValue;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final String hintText;
  final bool enableMode;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.9,
      // decoration: BoxDecoration(
      //     color: kPrimaryColor, borderRadius: BorderRadius.circular(29)),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: hintColor),
          labelText: enableMode? hintText: 'You are not allowed to edit the email',
          icon: Icon(
            icon,
            color: hintColor,
          ),
          // hintText: hintText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hintColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:  hintColor),
          ),
        ),
        controller: TextEditingController()..text = initialValue,
        validator: validator,
        enabled: enableMode,
      ),
    );
  }
}