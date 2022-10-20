import 'dart:convert';

List<OffresModel> offresModelFromJson(String str) => List<OffresModel>.from(json.decode(str).map((x) => OffresModel.fromJson(x)));

String offresModelToJson(List<OffresModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OffresModel {
  OffresModel({
    required this.id,
    required this.name,
    required this.code,
    this.value = false,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  bool value;
  DateTime createdAt;
  DateTime updatedAt;

  factory OffresModel.fromJson(Map<String, dynamic> json) => OffresModel(
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