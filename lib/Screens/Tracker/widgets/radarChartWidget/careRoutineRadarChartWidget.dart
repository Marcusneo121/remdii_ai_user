import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fyp/DB_Models/Tracker/RadarChartRawDataSet.dart';
import 'package:fyp/constants.dart';

class CareRoutineRadarChartWidget extends StatefulWidget {
  const CareRoutineRadarChartWidget(
      {super.key, required this.careRoutineRawData});

  final List<RawDataSet> careRoutineRawData;

  @override
  State<CareRoutineRadarChartWidget> createState() =>
      _CareRoutineRadarChartWidgetState();
}

class _CareRoutineRadarChartWidgetState
    extends State<CareRoutineRadarChartWidget> {
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
                titlePositionPercentageOffset: 0.2,
                titleTextStyle:
                    const TextStyle(color: titleColor, fontSize: 14),
                getTitle: (index, angle) {
                  switch (index) {
                    case 0:
                      return RadarChartTitle(
                        text: 'Moisturiser',
                      );
                    case 1:
                      return RadarChartTitle(text: 'Topical Steroids');
                    case 2:
                      return RadarChartTitle(
                        text: 'Medicines',
                      );
                    case 3:
                      return RadarChartTitle(text: 'Immunosuppressant');
                    case 4:
                      return RadarChartTitle(text: 'Wet Wrap Therapy');
                    case 5:
                      return RadarChartTitle(text: 'Bleach Bath');
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
    return widget.careRoutineRawData;
  }
}
