class CaseDetails {
  final int caseID;
  final String detailID;
  var caseImg;
  final String date, time;
  final String result, severity;
  final String status, comments;
  final String foodLog;
  final String sleepTime, wakeTime;
  final int sleepingHrs;
  final String q1, q2, q3, q4;
  final String q1Ans, q2Ans, q3Ans, q4Ans;

  CaseDetails({
    required this.caseID,
    required this.detailID,
    required this.caseImg,
    required this.date,
    required this.time,
    required this.result,
    required this.severity,
    required this.status,
    required this.comments,
    required this.foodLog,
    required this.sleepTime,
    required this.wakeTime,
    required this.sleepingHrs,
    required this.q1,
    required this.q2,
    required this.q3,
    required this.q4,
    required this.q1Ans,
    required this.q2Ans,
    required this.q3Ans,
    required this.q4Ans,
  });
}
