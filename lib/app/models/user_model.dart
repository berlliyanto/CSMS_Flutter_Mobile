class UserModel {
  late String? name;
  late int? id;

  UserModel({this.name, this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      id: json['id'],
    );
  }
}