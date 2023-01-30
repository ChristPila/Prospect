
import 'dart:convert';

List<CommuneModel> communeModelFromJson(String str) => List<CommuneModel>.from(json.decode(str).map((x) => CommuneModel.fromJson(x)));

String communeModelToJson(List<CommuneModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommuneModel {
  CommuneModel({
    required this.id,
    required this.name,
    required this.code,
    required this.zoneId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  int zoneId;
  DateTime createdAt;
  DateTime updatedAt;

  factory CommuneModel.fromJson(Map<String, dynamic> json) => CommuneModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    zoneId: json["zone_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "zone_id": zoneId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
