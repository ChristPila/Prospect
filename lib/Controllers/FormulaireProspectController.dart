import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:gallery_saver/files.dart';
import 'package:http/http.dart' as http;
import 'package:prospect/Models/ActiviteModel.dart';
import 'package:prospect/Models/CommuneModel.dart';
import 'package:prospect/Models/OffresModel.dart';
import 'package:prospect/Models/ProspectModel.dart';
import 'package:prospect/Models/VilleModel.dart';
import 'package:prospect/Models/ZoneModel.dart';


import '../Models/ProvinceModel.dart';
import '../Models/prosModel.dart';
import '../Tools/Parametres.dart';

class FormulaireProspectController with ChangeNotifier {
  var stockage = GetStorage(Parametres.STOCKAGE_VERSION);
  List<ProvinceModel> provinces = [];
  List<VilleModel> villes = [];
  List<ZoneModel> zones = [];
  List<CommuneModel> communes = [];
  List<ActiviteModel> activities = [];
  List<OffresModel> offres = [];

  Future<dynamic> submitProspect(dynamic data) async {
    var res = json.encode(data);
    var header = {"Content-Type": "application/json"};
    var url = Uri.http('10.20.20.150:8081', Parametres.endPointProspect);
    var response = await http.post(url, body: res, headers: header);
    print(url);
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return response.statusCode;
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
    notifyListeners();
  }

  lecturestockageLocale(String key) {
    var locale = stockage.read<String>(key);
    if (locale != null) {
      var temp = json.decode(locale) as Map;
      return temp;
    } else {
      print("Fichier inexistant");
      return {};
    }
  }

  ecritureStockageLocale(String key, Map stockage_data)  {
    //var temp = data.map((e) => e.toJson()).toList();
    stockage.write(key, json.encode(stockage_data));
  }

  lectureAPIstockage(String key, endPoints) async{
    var mapProvince = lecturestockageLocale(key);
    var provinces = mapProvince.entries
        .map((e) => e.value)
        .toList();
    if(provinces.length == 0){
      provinces = await recupererDonneesAPI(
          key, endPoints);
    }
    return provinces;
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
