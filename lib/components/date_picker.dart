import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? date;

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd MMM yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        // margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: FractionalOffset.centerLeft,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
            backgroundColor: Color(0xFFDEDEDE), // background (button) color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(FontAwesomeIcons.calendarAlt,
                  color: Color(0xFF6C6C6C), size: 17.0),
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
          onPressed: () => pickDate(context),
        ),
      );

  Future pickDate(BuildContext context) async {
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 5))) &&
          day.isBefore(DateTime.now().add(Duration(days: 0))))) {
        return true;
      }
      return false;
    }

    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
