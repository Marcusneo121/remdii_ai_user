import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Tracker/RadarChartRawDataSet.dart';
import 'package:fyp/constants.dart';

class FoodRadarChartWidget extends StatefulWidget {
  const FoodRadarChartWidget({super.key, required this.foodRawData});

  final List<RawDataSet> foodRawData;

  @override
  State<FoodRadarChartWidget> createState() => _FoodRadarChartWidgetState();
}

class _FoodRadarChartWidgetState extends State<FoodRadarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: RadarChart(
              RadarChartData(
                dataSets: showingDataSets(),
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: Colors.transparent),
                titlePositionPercentageOffset: 0.3,
                titleTextStyle:
                    const TextStyle(color: titleColor, fontSize: 14),
                getTitle: (index, angle) {
                  switch (index) {
                    case 0:
                      return RadarChartTitle(
                        text: 'Egg',
                      );
                    case 1:
                      return RadarChartTitle(text: "Cow's Milk");
                    case 2:
                      return RadarChartTitle(
                        text: 'Soy',
                      );
                    case 3:
                      return RadarChartTitle(text: 'Peanut');
                    case 4:
                      return RadarChartTitle(text: 'Seafood');
                    case 5:
                      return RadarChartTitle(text: 'Wheat/Gluten');
                    default:
                      return const RadarChartTitle(text: '');
                  }
                },
                tickCount: 1,
                ticksTextStyle:
                    const TextStyle(color: Colors.transparent, fontSize: 10),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: const BorderSide(color: gridColor, width: 2),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final rawDataSet = entry.value;

      return RadarDataSet(
        fillColor: rawDataSet.color.withOpacity(0.5),
        borderColor: rawDataSet.color,
        entryRadius: 3,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: 2.3,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return widget.foodRawData;
    // return [
    //   RawDataSet(
    //     title: 'Foods',
    //     color: fashionColor,
    //     values: [
    //       300,
    //       0,
    //       300,
    //     ],
    //   ),
    // RawDataSet(
    //   title: 'Art & Tech',
    //   color: artColor,
    //   values: [
    //     250,
    //     100,
    //     200,
    //   ],
    // ),
    // RawDataSet(
    //   title: 'Entertainment',
    //   color: entertainmentColor,
    //   values: [
    //     200,
    //     150,
    //     50,
    //   ],
    // ),
    // RawDataSet(
    //   title: 'Off-road Vehicle',
    //   color: offRoadColor,
    //   values: [
    //     150,
    //     200,
    //     150,
    //   ],
    // ),
    // RawDataSet(
    //   title: 'Boxing',
    //   color: boxingColor,
    //   values: [
    //     100,
    //     250,
    //     100,
    //   ],
    // ),
    // ];
  }
}
