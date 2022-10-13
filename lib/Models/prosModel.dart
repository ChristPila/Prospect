// To parse this JSON data, do
//
//     final prosModel = prosModelFromMap(jsonString);

import 'dart:convert';

ProsModel prosModelFromMap(String str) => ProsModel.fromMap(json.decode(str));

String prosModelToMap(ProsModel data) => json.encode(data.toMap());

class ProsModel {
  ProsModel({
    this.id,
    this.location,
    this.agent,
    this.companyName,
    this.companyPhone,
    this.companyAddress,
    this.companyType,
    this.offre,
    this.piecejointes,
    this.remonteId,
    this.commune,
  });

  int? id;
  String? location;
  Agent? agent;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  CompanyType? companyType;
  Offre? offre;
  List<Piecejointe>? piecejointes;
  String? remonteId;
  Commune? commune;

  factory ProsModel.fromMap(Map<String, dynamic> json) => ProsModel(
    id: json["id"] == null ? null : json["id"],
    location: json["location"] == null ? null : json["location"],
    agent: json["agent"] == null ? null : Agent.fromMap(json["agent"]),
    companyName: json["company_name"] == null ? null : json["company_name"],
    companyPhone: json["company_phone"] == null ? null : json["company_phone"],
    companyAddress: json["company_address"] == null ? null : json["company_address"],
    companyType: json["company_type"] == null ? null : CompanyType.fromMap(json["company_type"]),
    offre: json["offre"] == null ? null : Offre.fromMap(json["offre"]),
    piecejointes: json["piecejointes"] == null ? null : List<Piecejointe>.from(json["piecejointes"].map((x) => Piecejointe.fromMap(x))),
    remonteId: json["remonte_id"] == null ? null : json["remonte_id"],
    commune: json["commune"] == null ? null : Commune.fromMap(json["commune"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "location": location == null ? null : location,
    "agent": agent == null ? null : agent!.toMap(),
    "company_name": companyName == null ? null : companyName,
    "company_phone": companyPhone == null ? null : companyPhone,
    "company_address": companyAddress == null ? null : companyAddress,
    "company_type": companyType == null ? null : companyType!.toMap(),
    "offre": offre == null ? null : offre!.toMap(),
    "piecejointes": piecejointes == null ? null : List<dynamic>.from(piecejointes!.map((x) => x.toMap())),
    "remonte_id": remonteId == null ? null : remonteId,
    "commune": commune == null ? null : commune!.toMap(),
  };
}

class Agent {
  Agent({
    this.id,
    this.identity,
  });

  int? id;
  String? identity;

  factory Agent.fromMap(Map<String, dynamic> json) => Agent(
    id: json["id"] == null ? null : json["id"],
    identity: json["identity"] == null ? null : json["identity"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "identity": identity == null ? null : identity,
  };
}

class Commune {
  Commune({
    this.id,
    this.name,
    this.zone,
  });

  int? id;
  String? name;
  Zone? zone;

  factory Commune.fromMap(Map<String, dynamic> json) => Commune(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    zone: json["zone"] == null ? null : Zone.fromMap(json["zone"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "zone": zone == null ? null : zone!.toMap(),
  };
}

class Zone {
  Zone({
    this.id,
    this.name,
    this.ville,
  });

  int? id;
  String? name;
  Ville? ville;

  factory Zone.fromMap(Map<String, dynamic> json) => Zone(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    ville: json["ville"] == null ? null : Ville.fromMap(json["ville"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "ville": ville == null ? null : ville!.toMap(),
  };
}

class Ville {
  Ville({
    this.id,
    this.name,
    this.province,
  });

  int? id;
  String? name;
  Province? province;

  factory Ville.fromMap(Map<String, dynamic> json) => Ville(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    province: json["province"] == null ? null : Province.fromMap(json["province"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "province": province == null ? null : province!.toMap(),
  };
}

class CompanyType {
  CompanyType({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CompanyType.fromMap(Map<String, dynamic> json) => CompanyType(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Offre {
  Offre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Offre.fromMap(Map<String, dynamic> json) => Offre(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Province {
  Province({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Province.fromMap(Map<String, dynamic> json) => Province(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Piecejointe {
  Piecejointe({
    this.id,
    this.path,
    this.type,
  });

  int? id;
  String? path;
  String? type;

  factory Piecejointe.fromMap(Map<String, dynamic> json) => Piecejointe(
    id: json["id"] == null ? null : json["id"],
    path: json["path"] == null ? null : json["path"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "path": path == null ? null : path,
    "type": type == null ? null : type,
  };
}
