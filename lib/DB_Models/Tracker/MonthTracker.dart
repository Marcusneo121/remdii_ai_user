class MonthTracker {
  final int lineChartID;
  final int weekLevel;
  final int poem;
  final DateTime publishedAt;
  final int userID;
  final String month;
  final String week;
  final String year;
  final int radarChartID;
  final String monthTitle;

  MonthTracker(
      {required this.lineChartID,
      required this.weekLevel,
      required this.poem,
      required this.publishedAt,
      required this.userID,
      required this.month,
      required this.week,
      required this.year,
      required this.radarChartID,
      required this.monthTitle});
}
