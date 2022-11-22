
import 'dart:convert';

List<ZoneModel> zoneModelFromJson(String str) => List<ZoneModel>.from(json.decode(str).map((x) => ZoneModel.fromJson(x)));

String zoneModelToJson(List<ZoneModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneModel {
  ZoneModel({
    required this.id,
    required this.name,
    required this.code,
    required this.villeId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  int villeId;
  DateTime createdAt;
  DateTime updatedAt;

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    villeId: json["ville_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "ville_id": villeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
