// To parse this JSON data, do
//
//     final activiteModel = activiteModelFromJson(jsonString);

import 'dart:convert';

List<ActiviteModel> activiteModelFromJson(String str) => List<ActiviteModel>.from(json.decode(str).map((x) => ActiviteModel.fromJson(x)));

String activiteModelToJson(List<ActiviteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActiviteModel {
  ActiviteModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory ActiviteModel.fromJson(Map<String, dynamic> json) => ActiviteModel(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
