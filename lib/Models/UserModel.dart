class Authentification {
  final String? token;
  final String? error;

  Authentification({required this.token, required this.error});

  factory Authentification.fromJson(Map<String, dynamic> json) {
    return Authentification(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
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