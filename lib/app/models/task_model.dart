import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';

class TaskPaginateModel {
  final int currentPage;
  final List<TasksByCleanerModel> data;
  final String firstPageUrl;
  final int from;
  final String lastPageUrl;
  final int lastPage;
  final List<LinkModel> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  TaskPaginateModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPageUrl,
    required this.lastPage,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory TaskPaginateModel.fromJson(Map<String, dynamic> json) =>
      TaskPaginateModel(
        currentPage: json["current_page"],
        data: List<TasksByCleanerModel>.from(
            json["data"].map((x) => TasksByCleanerModel.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPageUrl: json["last_page_url"],
        lastPage: json["last_page"],
        links: List<LinkModel>.from(
            json["links"].map((x) => LinkModel.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class LinkModel {
  final String url;
  final String label;
  final bool active;

  LinkModel({
    required this.url,
    required this.label,
    required this.active,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}
