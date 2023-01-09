import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/DB_Models/Tracker/LineChartPoint.dart';
import 'package:fyp/Screens/Tracker/tracker_line_chart_screen.dart';
import 'package:fyp/Screens/Tracker/tracker_radar_chart_screen.dart';
import 'package:fyp/constants.dart';
import 'package:vibration/vibration.dart';

class LineChartWidget extends StatelessWidget {
  final List<LineChartPoint> points;
  final String year;
  final String month, monthTitle;
  final BuildContext context;
  final List<LineChartDataCarry> dataCollections;
  const LineChartWidget({
    Key? key,
    required this.points,
    required this.month,
    required this.monthTitle,
    required this.year,
    required this.context,
    required this.dataCollections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eczema Level',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: const Color(0xff37434d),
          ),
        ),
        SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 2,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                verticalInterval: 1,
                horizontalInterval: 1,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.white,
                    strokeWidth: 1,
                  );
                },
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                    dashArray: [5, 10],
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 38,
                    getTitlesWidget: bottomTitleWidgets,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftTitleWidgets,
                    reservedSize: 35,
                    interval: 1,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  top: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Color(0xff37434d),
                  ),
                  bottom: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Color(0xff37434d),
                  ),
                ),
              ),
              minX: 0,
              maxX: 3,
              minY: 0,
              maxY: 4,
              lineBarsData: [
                LineChartBarData(
                  spots:
                      points.map((point) => FlSpot(point.x, point.y)).toList(),
                  isCurved: false,
                  color: buttonColor,
                  dotData: FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      //color: Color(0xff68737d),
      fontFamily: 'Lato',
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
          ),
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Week 1', style: style),
                //Text('(1/1 - 7/1)', style: style),
              ]),
        );
        break;
      case 1:
        text = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
          ),
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Week 2', style: style),
                //Text('(8/1 - 16/1)', style: style),
              ]),
        );
        break;
      case 2:
        text = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
          ),
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Week 3', style: style),
                //Text('(17/1 - 25/1)', style: style),
              ]),
        );
        break;
      case 3:
        text = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
          ),
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Week 4', style: style),
                //Text('(26/1 - 31/1)', style: style),
              ]),
        );
        break;
      default:
        text = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonColor,
          ),
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('', style: style),
                //Text('', style: style),
              ]),
        );
        break;
    }

    return Bounceable(
      onTap: () {
        Vibration.vibrate(amplitude: 40, duration: 200);
        if (value == 0) {
          if (dataCollections[value.toInt()].radarChartID == null) {
            Fluttertoast.showToast(
                msg: "No record(s) for Week 1",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: buttonColor,
                textColor: Colors.white,
                fontSize: 15.0);
          } else {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => TrackerRadarChartScreen(
                  year: year,
                  month: month,
                  monthTitle: monthTitle,
                  week: '1',
                  radarChartID: dataCollections[value.toInt()].radarChartID,
                ),
              ),
            );
          }
        } else if (value == 1) {
          if (dataCollections[value.toInt()].radarChartID == null) {
            Fluttertoast.showToast(
                msg: "No record(s) for Week 2",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: buttonColor,
                textColor: Colors.white,
                fontSize: 15.0);
          } else {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => TrackerRadarChartScreen(
                  year: year,
                  month: month,
                  monthTitle: monthTitle,
                  week: '2',
                  radarChartID: dataCollections[value.toInt()].radarChartID,
                ),
              ),
            );
          }
        } else if (value == 2) {
          if (dataCollections[value.toInt()].radarChartID == null) {
            Fluttertoast.showToast(
                msg: "No record(s) for Week 3",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: buttonColor,
                textColor: Colors.white,
                fontSize: 15.0);
          } else {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => TrackerRadarChartScreen(
                  year: year,
                  month: month,
                  monthTitle: monthTitle,
                  week: '3',
                  radarChartID: dataCollections[value.toInt()].radarChartID,
                ),
              ),
            );
          }
        } else if (value == 3) {
          if (dataCollections[value.toInt()].radarChartID == null) {
            Fluttertoast.showToast(
                msg: "No record(s) for Week 4",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: buttonColor,
                textColor: Colors.white,
                fontSize: 15.0);
          } else {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => TrackerRadarChartScreen(
                  year: year,
                  month: month,
                  monthTitle: monthTitle,
                  week: '4',
                  radarChartID: dataCollections[value.toInt()].radarChartID,
                ),
              ),
            );
          }
        }
      },
      child: SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: 'Lato',
      color: Color(0xff67727d),
      fontWeight: FontWeight.w800,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '1';
        break;
      case 2:
        text = '2';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '4';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
