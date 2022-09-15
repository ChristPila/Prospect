
import 'dart:convert';
ProspectModel prospectModelFromJson(String str) => ProspectModel.fromJson(json.decode(str));
String prospectModelToJson(ProspectModel data) => json.encode(data.toJson());
class ProspectModel {
  ProspectModel({
    this.id,
    this.nomPointVent,
    this.agentTerrain,
    this.phone,
    this.progression,
    this.ville,
    this.detail,
  });
  int? id;
  String? nomPointVent;
  String? agentTerrain;
  int? phone;
  String? progression;
  String? ville;
  String? detail;
  factory ProspectModel.fromJson(Map<String, dynamic> json) => ProspectModel(
    id: json["Id"] == null ? null : json["Id"],
    nomPointVent: json["NomPointVent"] == null ? null : json["NomPointVent"],
    agentTerrain: json["AgentTerrain"] == null ? null : json["AgentTerrain"],
    phone: json["Phone"] == null ? null : json["Phone"],
    progression: json["Progression"] == null ? null : json["Progression"],
    ville: json["Ville"] == null ? null : json["Ville"],
    detail: json["Detail"] == null ? null : json["Detail"],
  );
  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "NomPointVent": nomPointVent == null ? null : nomPointVent,
    "AgentTerrain": agentTerrain == null ? null : agentTerrain,
    "Phone": phone == null ? null : phone,
    "Progression": progression == null ? null : progression,
    "Ville": ville == null ? null : ville,
    "Detail": detail == null ? null : detail,
  };
}