import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prospect/Models/ActiviteModel.dart';
import 'package:prospect/Models/CommuneModel.dart';
import 'package:prospect/Models/OffresModel.dart';
import 'package:prospect/Models/VilleModel.dart';
import 'package:prospect/Models/ZoneModel.dart';

import '../Models/ProvinceModel.dart';
import '../Models/prosModel.dart';
import '../Tools/Parametres.dart';

class FormulaireProspectController with ChangeNotifier {
  var stockage = GetStorage(Parametres.STOCKAGE_VERSION);
  Map mapProvinces = {};
  List<ProvinceModel> provinces = [];

  Map mapVilles = {};
  List<VilleModel> villes = [];

  Map mapZones = {};
  List<ZoneModel> zones = [];

  Map mapCommunes = {};
  List<CommuneModel> communes = [];

  Map mapActivities = {};
  List<ActiviteModel> activities = [];

  Map mapOffres = {};
  List<OffresModel> offres = [];

  Future<dynamic> submitProspect(ProsModel data) async {
    var jsonData = data.toJson();
    jsonData['state'] = "1";
    var res = json.encode(jsonData);
    var header = {"Content-Type": "application/json"};
    var url = Uri.parse(
        '${Parametres.scheme}://${Parametres.host}:${Parametres.port}/${Parametres.endPointProspect}');
    print(url);

    try {
      var response = await http.post(url, body: res, headers: header);
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data['data']['id'];
      }
      throw Exception("Echec de creation");
    } on Exception catch (e, trace) {
      print("Erreur: $e");
      print("Trace: $trace");
      throw Exception("Erreur inattendue");
    }
  }

  recupererDonneesAPI(String key, rebase) async {
    var localData = lecturestockageLocale(key);
    var url = Uri.parse(
        '${Parametres.scheme}://${Parametres.host}:${Parametres.port}/${rebase}');

    print("URL = $url");
    var reponse = await http.get(url).timeout(Duration(seconds: 5));
    String result = reponse.body;
    print("result $result");
    if (reponse.statusCode == 200) {
      var donneesAPI = json.decode(result) as List<dynamic>;
      print("result ${donneesAPI.length}");
      Map tempmap = Map.fromIterable(donneesAPI,
          key: (v) => v['id'].toString(),
          value: (v) => v); // conversion donnees api en map
      print(tempmap);
      localData = {
        ...localData,
        ...tempmap
      }; //fusion des donnees local et de l'api map
      var tempmapdata = localData.entries
          .map((e) => e.value)
          .toList(); // conversion des donnees fusionnees en liste
      notifyListeners();
      print(reponse.body);

      print("local_data ${tempmapdata.length}");
      ecritureStockageLocale(key, localData);
      return tempmapdata;
    } else {
      print("Erreur Reception données");
      return [];
    }
  }

  Map lecturestockageLocale(String key) {
    var locale = stockage.read<String>(key);
    if (locale != null) {
      var temp = json.decode(locale) as Map;
      return temp;
    } else {
      print("Fichier inexistant");
      return {};
    }
  }

  ecritureStockageLocale(String key, Map stockage_data) {
    //var temp = data.map((e) => e.toJson()).toList();
    stockage.write(key, json.encode(stockage_data));
  }

  Future<Map<String, dynamic>> lectureAPIstockage(String key, endPoints) async {
    var mapData = lecturestockageLocale(key);
    var data = mapData.entries.map((e) => e.value).toList();
    if (data.length == 0) {
      data = await recupererDonneesAPI(key, endPoints);
    }
    return {"mapData": mapData, "listData": data};
  }

  provinceRecup() async {
    Map res = await lectureAPIstockage(
        Parametres.keyProvince, Parametres.endPointProvinces);
    provinces = res['listData']
        .map<ProvinceModel>((e) => ProvinceModel.fromJson(e))
        .toList();
    mapProvinces = res['mapData'];
    notifyListeners();
  }

  villeRecup() async {
    Map res =
        await lectureAPIstockage(Parametres.keyVilles, Parametres.keyVilles);
    villes =
        res['listData'].map<VilleModel>((e) => VilleModel.fromJson(e)).toList();
    mapVilles = res['mapData'];
    notifyListeners();
  }

  zoneRecup() async {
    Map res =
        await lectureAPIstockage(Parametres.keyZones, Parametres.endPointZones);
    zones =
        res['listData'].map<ZoneModel>((e) => ZoneModel.fromJson(e)).toList();
    mapZones = res['mapData'];
    notifyListeners();
  }

  communeRecup() async {
    Map res = await lectureAPIstockage(
        Parametres.keyCommunes, Parametres.endPointCommunes);
    communes = res['listData']
        .map<CommuneModel>((e) => CommuneModel.fromJson(e))
        .toList();
    mapCommunes = res['mapData'];
    notifyListeners();
  }

  activityRecup() async {
    Map res = await lectureAPIstockage(
        Parametres.keyActivities, Parametres.endPointAct);
    activities = res['listData']
        .map<ActiviteModel>((e) => ActiviteModel.fromJson(e))
        .toList();
    mapActivities = res['mapData'];
    notifyListeners();
  }

  offreRecup() async {
    Map res = await lectureAPIstockage(
        Parametres.keyOffres, Parametres.endPointOffres);
    offres = res['listData']
        .map<OffresModel>((e) => OffresModel.fromJson(e))
        .toList();
    mapOffres = res['mapData'];
    notifyListeners();
  }

  creerCopieLocale(ProsModel brou) {
    brou.state = brou.state ?? "4";

    var cle = "${Parametres.keyProspect}_${brou.agentId}";
    Map a = lecturestockageLocale(cle);
    a[brou.remoteId] = brou.toJson();
    ecritureStockageLocale(cle, a);
  }
}
/*main(){
  var data = {
    "longitude":"-4,3333333",
    "latitude":"15,306777",
    "agent_id":"1",
    "commune_id":"1",
    "zone_id":"1",
    "ville_id":"1",
    "province_id":"1",
    "company_name":"ODC",
    "company_address":"Huilerie",
    "company_type_id":"1",
    "company_phone":"0854567890",
    "offer_id":"1",
    "state":"1",
    "pieces_jointes_id":"1",
    "remote_id":"k&éjdnop&123"
  };
  ProspectController().submitProspect(data);
  }*/
