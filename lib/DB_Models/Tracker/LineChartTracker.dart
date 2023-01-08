class LineChartTracker {
  final int lineChartID;
  final int weekLevel;
  final int poem;
  final DateTime? publishedAt;
  final String month;
  final String week;
  final String year;
  final int? radarChartID;
  final String onPressedTitle;

  LineChartTracker(
      {required this.lineChartID,
      required this.weekLevel,
      required this.poem,
      required this.publishedAt,
      required this.month,
      required this.week,
      required this.year,
      required this.radarChartID,
      required this.onPressedTitle});
}
