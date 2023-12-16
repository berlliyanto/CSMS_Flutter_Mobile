class CountAssignModel{
  final int total, finish, notFinish;
  CountAssignModel({required this.total, required this.finish, required this.notFinish});

  factory CountAssignModel.fromJson(Map<String, dynamic> json) {
    return CountAssignModel(
      total: json["total"],
      finish: json["total_finish"],
      notFinish: json["total_not_finish"],
    );
  }
}