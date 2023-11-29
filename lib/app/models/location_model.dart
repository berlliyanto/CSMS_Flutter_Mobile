class LocationModel {
  late String? name;
  late int? id;

  LocationModel({this.id, this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(
      name: json['location_name'],
      id: json['id'],
    );
  }
}