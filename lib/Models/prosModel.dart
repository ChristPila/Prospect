// To parse this JSON data, do
//
//     final prosModel = prosModelFromJson(jsonString);

import 'dart:convert';

List<ProsModel> prosModelFromJson(String str) => List<ProsModel>.from(json.decode(str).map((x) => ProsModel.fromJson(x)));

String prosModelToJson(List<ProsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProsModel {
  ProsModel({
    this.longitude,
    this.latitude,
    this.agentId,
    this.communeId,
    this.zoneId,
    this.villeId,
    this.provinceId,
    this.companyName,
    this.companyAddress,
    this.typeActivitiesId,
    this.companyPhone,
    this.offerId,
    this.state,
    this.piecesJointesId,
    this.remoteId,
  });

  String? longitude;
  String? latitude;
  int? agentId;
  int? communeId;
  int? zoneId;
  int? villeId;
  int? provinceId;
  String? companyName;
  String? companyAddress;
  int? typeActivitiesId;
  String? companyPhone;
  int? offerId;
  String? state;
  int? piecesJointesId;
  String? remoteId;

  factory ProsModel.fromJson(Map<String, dynamic> json) => ProsModel(
    longitude: json["longitude"],
    latitude: json["latitude"],
    agentId: json["agent_id"],
    communeId: json["commune_id"],
    zoneId: json["zone_id"],
    villeId: json["ville_id"],
    provinceId: json["province_id"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    typeActivitiesId: json["type_activities_id"],
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
    "type_activities_id": typeActivitiesId,
    "company_phone": companyPhone,
    "offer_id": offerId,
    "state": state,
    "pieces_jointes_id": piecesJointesId,
    "remote_id": remoteId,
  };
}
