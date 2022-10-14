import 'dart:convert';

ProspectModel prospectModelFromJson(String str) =>
    ProspectModel.fromJson(json.decode(str));

String prospectModelToJson(ProspectModel data) => json.encode(data.toJson());

class ProspectModel {
  ProspectModel({
    this.id,
    this.latitude,
    this.longitude,
    this.agent,
    this.commune,
    this.companyName,
    this.companyAddress,
    this.companyType,
    this.companyPhone,
    this.offres,
    this.state,
    this.piecesjointes,
    this.remoteId,
  });

  int? id;
  String? latitude;
  String? longitude;
  Agent? agent;
  Commune? commune;
  String? companyName;
  String? companyAddress;
  CompanyType? companyType;
  String? companyPhone;
  List<Offre>? offres;

  String? state;
  List<Piecesjointe>? piecesjointes;
  String? remoteId;

  factory ProspectModel.fromJson(Map<String, dynamic> json) => ProspectModel(
        id: json["id"] == null ? null : json["id"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
        commune:
            json["commune"] == null ? null : Commune.fromJson(json["commune"]),
        companyName: json["company_name"] == null ? null : json["company_name"],
        companyAddress:
            json["company_address"] == null ? null : json["company_address"],
        companyType: json["company_type"] == null
            ? null
            : CompanyType.fromJson(json["company_type"]),
        companyPhone:
            json["company_phone"] == null ? null : json["company_phone"],
        offres: json["offres"] == null
            ? []
            : List<Offre>.from(json["offres"].map((x) => Offre.fromJson(x))),
        state: json["state"] == null ? null : json["state"],
        piecesjointes: json["piecesjointes"] == null
            ? []
            : List<Piecesjointe>.from(
                json["piecesjointes"].map((x) => Piecesjointe.fromJson(x))),
        remoteId: json["remote_id"] == null ? null : json["remote_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "agent": agent == null ? null : agent!.toJson(),
        "commune": commune == null ? null : commune!.toJson(),
        "company_name": companyName == null ? null : companyName,
        "company_address": companyAddress == null ? null : companyAddress,
        "company_type": companyType == null ? null : companyType!.toJson(),
        "company_phone": companyPhone == null ? null : companyPhone,
        "offres": offres == null
            ? null
            : List<dynamic>.from(offres!.map((x) => x.toJson())),
        "state": state == null ? null : state,
        "piecesjointes": piecesjointes == null
            ? null
            : List<dynamic>.from(piecesjointes!.map((x) => x.toJson())),
        "remote_id": remoteId == null ? null : remoteId,
      };
}

class Agent {
  Agent({
    this.id,
    this.identity,
  });

  int? id;
  String? identity;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        id: json["id"] == null ? null : json["id"],
        identity: json["identity"] == null ? null : json["identity"],
      );

  Map<String, dynamic> toJson() => {
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

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        zone: json["zone"] == null ? null : Zone.fromJson(json["zone"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "zone": zone == null ? null : zone!.toJson(),
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

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        ville: json["ville"] == null ? null : Ville.fromJson(json["ville"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "ville": ville == null ? null : ville!.toJson(),
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

  factory Ville.fromJson(Map<String, dynamic> json) => Ville(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        province: json["province"] == null
            ? null
            : Province.fromJson(json["province"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "province": province == null ? null : province!.toJson(),
      };
}

class Province {
  Province({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class CompanyType {
  CompanyType({
    this.id,
    this.name,
  });

  int? id;
  dynamic name;

  factory CompanyType.fromJson(Map<String, dynamic> json) => CompanyType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
      };
}

class Offre {
  Offre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Offre.fromJson(Map<String, dynamic> json) => Offre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Piecesjointe {
  Piecesjointe({
    this.id,
    this.path,
    this.type,
  });

  int? id;
  String? path;
  String? type;

  factory Piecesjointe.fromJson(Map<String, dynamic> json) => Piecesjointe(
        id: json["id"] == null ? null : json["id"],
        path: json["path"] == null ? null : json["path"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "path": path == null ? null : path,
        "type": type == null ? null : type,
      };

}
