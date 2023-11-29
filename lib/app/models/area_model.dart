class AreaModel {
  late String? name;
  late int? id;

  AreaModel({this.name, this.id});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      name: json['area_name'],
      id: json['id'],
    );
  }
}