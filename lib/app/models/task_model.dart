
class TaskPaginateModel {
  late int? currentPage;
  late String? firstPageUrl;
  late int? from;
  late String? lastPageUrl;
  late int? lastPage;
  late List<LinkModel>? links;
  late String? nextPageUrl;
  late String? path;
  late int? perPage;
  late String? prevPageUrl;
  late int? to;
  late int? total;

  TaskPaginateModel({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPageUrl,
    this.lastPage,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory TaskPaginateModel.fromJson(Map<String, dynamic> json) =>
      TaskPaginateModel(
        currentPage: json["current_page"],
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
  final dynamic url;
  final dynamic label;
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
