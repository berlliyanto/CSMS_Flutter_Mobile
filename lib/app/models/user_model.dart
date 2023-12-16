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

class ProfileUserModel{
  final String name, email, username;
  final RoleModel role;
  final int id;

  ProfileUserModel({
    required this.name,
    required this.email,
    required this.username,
    required this.role,
    required this.id
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      role: RoleModel.fromJson(json['role']),
      id: json['id'],
    );
  }
}

class RoleModel{
  final int id;
  final String roleName;

  RoleModel({
    required this.id,
    required this.roleName,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'].runtimeType == int ? json['id'] : int.parse(json['id']),
      roleName: json['role_name'],
    );
  }
}