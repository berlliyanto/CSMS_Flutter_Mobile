class AssignmentAnalyticsModel {
  final int total, statusFinish, statusNotFinish, statusOnProgress;

  AssignmentAnalyticsModel({
    required this.total,
    required this.statusFinish,
    required this.statusNotFinish,
    required this.statusOnProgress
  });

  factory AssignmentAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AssignmentAnalyticsModel(
      total: json["total"],
      statusFinish: json["status_finish"],
      statusNotFinish: json["status_not_finish"],
      statusOnProgress: json["status_on_progress"],
    );
  }
}