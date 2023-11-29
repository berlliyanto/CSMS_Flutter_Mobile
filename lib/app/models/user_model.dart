class CleanerModel {
  late String? name;
  late int? id;

  CleanerModel({this.name, this.id});

  factory CleanerModel.fromJson(Map<String, dynamic> json) {
    return CleanerModel(
      name: json['name'],
      id: json['id'],
    );
  }
}