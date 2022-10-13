import 'dart:convert';

import 'package:intl/intl.dart';

LastThreeMonthsModel LastThreeMonthsModelFromJson(String str) =>
    LastThreeMonthsModel.fromJson(json.decode(str));

String LastThreeWeeksModelToJson(LastThreeMonthsModel data) =>
    json.encode(data.toJson());

class LastThreeMonthsModel {
  LastThreeMonthsModel(
      {this.userId, this.id, this.nombre, this.mois, this.moisFormatted});

  int? userId;
  int? id;
  int? nombre;
  int? mois;
  String? moisFormatted;

  factory LastThreeMonthsModel.fromJson(Map<String, dynamic> json) {
    var mois = json["mois"] == null ? null : json["mois"];
    String? moisFormatted;
    if (mois != null) {
      DateTime now = DateTime.now();
      var date_month = DateTime(now.year, mois, 1);
      moisFormatted = DateFormat('MMMM').format(date_month);
    }

    return LastThreeMonthsModel(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        nombre: json["nombre"] == null ? null : json["nombre"],
        mois: mois,
        moisFormatted: moisFormatted);
  }

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
    "id": id == null ? null : id,
    "nombre": nombre == null ? null : nombre,
    "mois": mois == null ? null : mois,
  };
}
