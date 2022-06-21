import 'package:flutter/material.dart';
import 'package:fyp/constants.dart';

class Expandable extends StatefulWidget {
  final String title;
  final String image;

  const Expandable({Key? key, required this.title, required this.image,}) : super(key: key);

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                  color: buttonColor,
                ),
              ),
              InkWell(
                child: RotatedBox(
                  quarterTurns: _expanded? 3 : 0,
                  child: Icon(
                      Icons.chevron_right
                  ),
                ),
                onTap: () => setState(() => _expanded = !_expanded),
              )
            ],
          ),
          SizedBox(height: 10.0,),
          AnimatedSize(
            duration: Duration(milliseconds: 200),
            //vsync: this,
            child: ConstrainedBox(
              constraints: _expanded ? BoxConstraints() : BoxConstraints(maxHeight: 0),
              child: Image.asset(
                widget.image,
                fit: BoxFit.fill,
                width: 200.0,
                height: 200.0,
              ),
            ),

          )
        ],
      ),
    );
  }
}
