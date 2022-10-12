import 'dart:convert';
import 'package:intl/intl.dart';

LastThreeDaysModel LastThreeDaysModelFromJson(String str) =>
    LastThreeDaysModel.fromJson(json.decode(str));

String countvisitModelToJson(LastThreeDaysModel data) =>
    json.encode(data.toJson());

class LastThreeDaysModel {
  LastThreeDaysModel(
      {this.userId, this.id, this.nombre, this.jour, this.jourFormatted});

  int? userId;
  int? id;
  int? nombre;
  String? jour;
  String? jourFormatted;

  factory LastThreeDaysModel.fromJson(Map<String, dynamic> json) {
    var jour = json["jour"] == null ? null : json["jour"];
    String? jourFormatted;
    if (jour != null) {
      var data_jour = DateTime.parse(jour);
      jourFormatted = DateFormat('EEEE').format(data_jour);
    }
    return LastThreeDaysModel(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        jour: jour,
        jourFormatted: jourFormatted);
  }

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
    "id": id == null ? null : id,
    "nombre": nombre == null ? null : nombre,
    "jour": jour == null ? null : jour,
  };
}
