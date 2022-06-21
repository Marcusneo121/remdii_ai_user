import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/Screens/Dashboard/Components/Update%20Recovery%20Progress/update_sleep_time_screen.dart';

class TimePickerWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  // TimeOfDay? sleep_time;
  // TimeOfDay? wake_time;

  TimePickerWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? time;

  String getText() {
    if (time == null) {
      return widget.text;
    } else {
      // return '${_time}';
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    }
  }

  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: FractionalOffset.centerLeft,
      child: RaisedButton(
        color: Color(0xFFDEDEDE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(29.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(widget.icon, color: Color(0xFF6C6C6C), size: 17.0),
            SizedBox(
              width: 25.0,
            ),
            Text(
              getText(),
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF6C6C6C),
                  fontSize: 16.0),
            ),
          ],
        ),
        onPressed: () => _selectTime(context),
      ),
    );

  Future _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialTime: TimeOfDay(hour: 11, minute: 00),
      context: context,
    );
    if (newTime != null) {
      time = newTime;
    }
    setState(() => time = newTime);
  }
}
