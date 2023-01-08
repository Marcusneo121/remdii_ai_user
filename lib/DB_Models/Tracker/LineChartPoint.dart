import 'package:collection/collection.dart';

class LineChartPoint {
  final double x;
  final double y;
  LineChartPoint({required this.x, required this.y});
}

List<LineChartPoint> get lineChartPoints {
  final data = <double>[4, 3, 0, 1];
  return data
      .mapIndexed(((index, element) =>
          LineChartPoint(x: index.toDouble(), y: element.toDouble())))
      .toList();
}
