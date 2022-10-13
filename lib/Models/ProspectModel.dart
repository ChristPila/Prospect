// To parse this JSON data, do
//
//     final prospectModel = prospectModelFromJson(jsonString);

import 'dart:convert';

List<ProspectModel> prospectModelFromJson(String str) => List<ProspectModel>.from(json.decode(str).map((x) => ProspectModel.fromJson(x)));

String prospectModelToJson(List<ProspectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProspectModel {
  ProspectModel({
    this.longitude,
    this.latitude,
    this.agentId,
    required this.communeId,
    required this.zoneId,
    required this.villeId,
    required this.provinceId,
    required this.companyName,
    required this.companyAddress,
    required this.companyTypeId,
    required this.companyPhone,
    required this.offerId,
    required this.state,
    this.piecesJointesId,
    this.remoteId,
  });

  String? longitude;
  String? latitude;
  String? agentId;
  String communeId;
  String zoneId;
  String villeId;
  String provinceId;
  String companyName;
  String companyAddress;
  String companyTypeId;
  String companyPhone;
  String offerId;
  String state;
  String? piecesJointesId;
  String? remoteId;

  factory ProspectModel.fromJson(Map<String, dynamic> json) => ProspectModel(
    longitude: json["longitude"],
    latitude: json["latitude"],
    agentId: json["agent_id"],
    communeId: json["commune_id"],
    zoneId: json["zone_id"],
    villeId: json["ville_id"],
    provinceId: json["province_id"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    companyTypeId: json["company_type_id"],
    companyPhone: json["company_phone"],
    offerId: json["offer_id"],
    state: json["state"],
    piecesJointesId: json["pieces_jointes_id"],
    remoteId: json["remote_id"],
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
    "agent_id": agentId,
    "commune_id": communeId,
    "zone_id": zoneId,
    "ville_id": villeId,
    "province_id": provinceId,
    "company_name": companyName,
    "company_address": companyAddress,
    "company_type_id": companyTypeId,
    "company_phone": companyPhone,
    "offer_id": offerId,
    "state": state,
    "pieces_jointes_id": piecesJointesId,
    "remote_id": remoteId,
  };
}
