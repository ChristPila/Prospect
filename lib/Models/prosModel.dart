// To parse this JSON data, do
//
//     final prosModel = prosModelFromJson(jsonString);
import 'dart:convert';
ProsModel prosModelFromJson(String str) => ProsModel.fromJson(json.decode(str));
String prosModelToJson(ProsModel data) => json.encode(data.toJson());
class ProsModel {
  ProsModel({
    this.id,
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
  int? id;
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
    id: json["id"] == null ? null : json["id"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    communeId: json["commune_id"] == null ? null : json["commune_id"],
    zoneId: json["zone_id"] == null ? null : json["zone_id"],
    villeId: json["ville_id"] == null ? null : json["ville_id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    companyAddress: json["company_address"] == null ? null : json["company_address"],
    typeActivitiesId: json["type_activities_id"] == null ? null : json["type_activities_id"],
    companyPhone: json["company_phone"] == null ? null : json["company_phone"],
    offerId: json["offer_id"] == null ? null : json["offer_id"],
    state: json["state"] == null ? null : json["state"],
    piecesJointesId: json["pieces_jointes_id"] == null ? null : json["pieces_jointes_id"],
    remoteId: json["remote_id"] == null ? null : json["remote_id"],
  );
  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "agent_id": agentId == null ? null : agentId,
    "commune_id": communeId == null ? null : communeId,
    "zone_id": zoneId == null ? null : zoneId,
    "ville_id": villeId == null ? null : villeId,
    "province_id": provinceId == null ? null : provinceId,
    "company_name": companyName == null ? null : companyName,
    "company_address": companyAddress == null ? null : companyAddress,
    "type_activities_id": typeActivitiesId == null ? null : typeActivitiesId,
    "company_phone": companyPhone == null ? null : companyPhone,
    "offer_id": offerId == null ? null : offerId,
    "state": state == null ? null : state,
    "pieces_jointes_id": piecesJointesId == null ? null : piecesJointesId,
    "remote_id": remoteId == null ? null : remoteId,
  };
}