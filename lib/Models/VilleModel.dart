// To parse this JSON data, do
//
//     final villeModel = villeModelFromJson(jsonString);

import 'dart:convert';

List<VilleModel> villeModelFromJson(String str) => List<VilleModel>.from(json.decode(str).map((x) => VilleModel.fromJson(x)));

String villeModelToJson(List<VilleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VilleModel {
  VilleModel({
    required this.id,
    required this.name,
    required this.code,
    required this.provinceId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  int provinceId;
  DateTime createdAt;
  DateTime updatedAt;

  factory VilleModel.fromJson(Map<String, dynamic> json) => VilleModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    provinceId: json["province_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "province_id": provinceId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
