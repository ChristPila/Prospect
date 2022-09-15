// To parse this JSON data, do
//
//     final prospectModel = prospectModelFromJson(jsonString);

import 'dart:convert';

ProspectModel prospectModelFromJson(String str) => ProspectModel.fromJson(json.decode(str));

String prospectModelToJson(ProspectModel data) => json.encode(data.toJson());

class ProspectModel {
  ProspectModel({
    this.id,
    this.location,
    this.agentId,
    this.province,
    this.ville,
    this.zone,
    this.commune,
    this.companyName,
    this.companyAdress,
    this.companyType,
    this.companyPhone,
    this.offer,
    this.visuel1,
    this.visuel2,
    this.document1,
    this.document2,
    this.signature,
    this.state,
  });

  int? id;
  String? location;
  int? agentId;
  int? province;
  int? ville;
  String? zone;
  int? commune;
  int? companyName;
  String? companyAdress;
  String? companyType;
  int? companyPhone;
  int? offer;
  String? visuel1;
  String? visuel2;
  String? document1;
  String? document2;
  String? signature;
  String? state;

  factory ProspectModel.fromJson(Map<String, dynamic> json) => ProspectModel(
    id: json["id"] == null ? null : json["id"],
    location: json["location"] == null ? null : json["location"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    province: json["province"] == null ? null : json["province"],
    ville: json["ville"] == null ? null : json["ville"],
    zone: json["zone"] == null ? null : json["zone"],
    commune: json["commune"] == null ? null : json["commune"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    companyAdress: json["company_adress"] == null ? null : json["company_adress"],
    companyType: json["company_type"] == null ? null : json["company_type"],
    companyPhone: json["company_phone"] == null ? null : json["company_phone"],
    offer: json["offer"] == null ? null : json["offer"],
    visuel1: json["visuel1"] == null ? null : json["visuel1"],
    visuel2: json["visuel2"] == null ? null : json["visuel2"],
    document1: json["document1"] == null ? null : json["document1"],
    document2: json["document"] == null ? null : json["document"],
    signature: json["signature"] == null ? null : json["signature"],
    state: json["state"] == null ? null : json["state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "location": location == null ? null : location,
    "agent_id": agentId == null ? null : agentId,
    "province": province == null ? null : province,
    "ville": ville == null ? null : ville,
    "zone": zone == null ? null : zone,
    "commune": commune == null ? null : commune,
    "company_name": companyName == null ? null : companyName,
    "company_adress": companyAdress == null ? null : companyAdress,
    "company_type": companyType == null ? null : companyType,
    "company_phone": companyPhone == null ? null : companyPhone,
    "offer": offer == null ? null : offer,
    "visuel1": visuel1 == null ? null : visuel1,
    "visuel2": visuel2 == null ? null : visuel2,
    "document1": document1 == null ? null : document1,
    "document": document2 == null ? null : document2,
    "signature": signature == null ? null : signature,
    "state": state == null ? null : state,
  };
}
