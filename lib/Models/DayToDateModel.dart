
import 'dart:convert';
import 'package:intl/intl.dart';

DayToDateModel dayToDateModelFromMap(String str) =>
    DayToDateModel.fromMap(json.decode(str));

String dayToDateModelToMap(DayToDateModel data) => json.encode(data.toMap());

class DayToDateModel {
  DayToDateModel({
    this.rapportSemaineActuelle,
    this.rapportSemainePassee,
  });

  List<RapportSemaineActuelle>? rapportSemaineActuelle;
  List<RapportSemainePassee>? rapportSemainePassee;

  factory DayToDateModel.fromMap(Map<String, dynamic> json) => DayToDateModel(
        rapportSemaineActuelle: json["rapport_semaine_actuelle"] == null
            ? null
            : List<RapportSemaineActuelle>.from(json["rapport_semaine_actuelle"]
                .map((x) => RapportSemaineActuelle.fromMap(x))),
        rapportSemainePassee: json["rapport-semaine_passee"] == null
            ? null
            : List<RapportSemainePassee>.from(json["rapport-semaine_passee"]
                .map((x) => RapportSemainePassee.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "rapport_semaine_actuelle": rapportSemaineActuelle == null
            ? null
            : List<dynamic>.from(rapportSemaineActuelle!.map((x) => x.toMap())),
        "rapport-semaine_passee": rapportSemainePassee == null
            ? null
            : List<dynamic>.from(rapportSemainePassee!.map((x) => x.toMap())),
      };
}

class RapportSemaineActuelle {
  RapportSemaineActuelle(
      {this.nombre, this.jour, this.semaineCurrent, this.jourFormatted});

  int? nombre;
  String? jour;
  int? semaineCurrent;
  String? jourFormatted;

  factory RapportSemaineActuelle.fromMap(Map<String, dynamic> json) {
    var jour = json["jour"] == null ? null : json["jour"];
    String? jourFormatted;
    if (jour != null) {
      var data_jour = DateTime.parse(jour);
      jourFormatted = DateFormat('EEEE').format(data_jour);
    }
    return RapportSemaineActuelle(
      nombre: json["nombre"] == null ? null : json["nombre"],
      jour: jour,
      jourFormatted: jourFormatted,
      semaineCurrent:
          json["semaine_current"] == null ? null : json["semaine_current"],
    );
  }

  Map<String, dynamic> toMap() => {
        "nombre": nombre == null ? null : nombre,
        "jour": jour == null ? null : jour,
        "semaine_current": semaineCurrent == null ? null : semaineCurrent,
      };
}

class RapportSemainePassee {
  RapportSemainePassee(
      {this.nombre, this.jour, this.semainePassed, this.jourFormatted});

  int? nombre;
  String? jour;
  int? semainePassed;
  String? jourFormatted;

  factory RapportSemainePassee.fromMap(Map<String, dynamic> json) {
    var jour = json["jour"] == null ? null : json["jour"];
    String? jourFormatted;
    if (jour != null) {
      var data_jour = DateTime.parse(jour);
      jourFormatted = DateFormat('EEEE').format(data_jour);
    }
    return RapportSemainePassee(
      nombre: json["nombre"] == null ? null : json["nombre"],
      jour: jour,
      jourFormatted: jourFormatted,
      semainePassed:
          json["semaine_passed"] == null ? null : json["semaine_passed"],
    );
  }

  Map<String, dynamic> toMap() => {
        "nombre": nombre == null ? null : nombre,
        "jour": jour == null ? null : jour,
        "semaine_passed": semainePassed == null ? null : semainePassed,
      };
}
