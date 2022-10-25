import 'dart:convert';

LastThreeWeeksModel LastThreeWeeksModelFromJson(String str) => LastThreeWeeksModel.fromJson(json.decode(str));
String LastThreeWeeksModelToJson(LastThreeWeeksModel data) => json.encode(data.toJson());

class LastThreeWeeksModel {
  LastThreeWeeksModel({
    this.nombre,
    this.semaine,
  });

  int? nombre;
  int? semaine;

  factory LastThreeWeeksModel.fromJson(Map<String, dynamic> json) => LastThreeWeeksModel(
    nombre: json["nombre"] == null ? null : json["nombre"],
    semaine: json["semaine"] == null ? null : json["semaine"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre == null ? null : nombre,
    "semaine": semaine == null ? null : semaine,
  };
}
