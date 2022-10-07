class AuthentificationModel {
  final String? token;
  final String? user;

  AuthentificationModel({required this.token, required this.user});

  factory AuthentificationModel.fromJson(Map<String, dynamic> json) {
    return AuthentificationModel(
      token: json["token"] != null ? json["token"] : "",
      user: json["user"] != null ? json["user"] : "",
    );
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id == null ? null : id,
      "email": email == null ? null : email,
      "name": name == null ? null : name,
      "role": role == null ? null : role
    };
    return map;
  }
}