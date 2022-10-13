import 'dart:convert';

List<ProvinceModel> provinceModelFromJson(String str) => List<ProvinceModel>.from(json.decode(str).map((x) => ProvinceModel.fromJson(x)));

String provinceModelToJson(List<ProvinceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvinceModel {
  ProvinceModel({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
