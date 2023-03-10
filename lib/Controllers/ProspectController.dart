import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prospect/Tools/Test.dart';

import '../Models/prosModel.dart';
import '../Tools/Parametres.dart';

class ProspectController with ChangeNotifier {
  List<ProsModel> data = [];
  Map stockage_data = {};
  Map zones = {};
  Map provinces = {};
  Map villes = {};
  Map communes = {};
  Map activity = {};
  Map offres = {};
  List<ProsModel> listValider = [];
  List<ProsModel> listRejeter = [];
  List<ProsModel> listAtente = [];
  List<ProsModel> listBrouillon = [];
  final stockage = GetStorage(Parametres.STOCKAGE_VERSION);

  int randomInt() {
   // print(Random().nextInt(100 - 0 + 1) + 0);
    return Random().nextInt(100 - 0 + 1) + 0;
  }

  recupererDonneesLocales(currentId) {
    lecturestockageLocale(currentId);
    var tempstrore = stockage_data.entries.map((e) => e.value).toList();
    data = tempstrore.map((e) => ProsModel.fromJson(e)).toList();
    notifyListeners();
  }

  recupererDonneesAPI(int currentId) async {
    lecturestockageLocale(currentId);
    try {
      var url = Uri.parse(
          '${Parametres.scheme}://${Parametres.host}:${Parametres.port}/${Parametres.rebase}');

      var reponse = await http.get(url).timeout(Duration(seconds: 5));
      String result = reponse.body;
      print("result $result");
      if (reponse.statusCode == 200) {
        var donneesAPImap = json.decode(result) as Map;
        var donneesAPI = donneesAPImap["response"]
            as List<dynamic>; //conversion donnees api en liste
        print("result ${donneesAPI.length}");
        Map tempmap = Map.fromIterable(donneesAPI,
            key: (v) => v['remote_id'].toString(),
            value: (v) => v); // conversion donnees api en map
        stockage_data = {
          ...stockage_data,
          ...tempmap
        }; //fusion des donnees local et de l'api map
        var tempmapdata = stockage_data.entries
            .map((e) => e.value)
            .toList(); // conversion des donnees fusionnees en liste
        data = tempmapdata
            .map((e) => ProsModel.fromJson(e))
            .toList(); //  conversion des donnees fusionnees en liste de prospect_model
        notifyListeners();
        print(reponse.body);

        print("local_data ${data.length}");
        ecritureStockageLocale(currentId);
      } else {
        print("Erreur Reception donn??es");
      }
    } catch (e) {
      print(e.toString());
      // generalement pour gerer les erreurs de connectivit??
    }

    notifyListeners();
  }

  verifierStatusDonneeAPI(String remote_id, int currentID) async {
    try {
      var url = Uri.parse(
          '${Parametres.scheme}://${Parametres.host}:${Parametres.port}/${Parametres.rebase}/$remote_id/${Parametres.endPoind}');

      print("url $url");
      var reponse = await http.get(url).timeout(Duration(seconds: 5));
      String result = reponse.body;
      print("result $result");
      if (reponse.statusCode == 200 || reponse.statusCode == 201) {
        var donneesAPI = json.decode(result) as Map;
        var newstate = donneesAPI["data"]["state"];
        stockage_data[remote_id]["state"] = newstate;
        var tempmapdata = stockage_data.entries
            .map((e) => e.value)
            .toList(); // conversion des donnees fusionnees en liste
        data = tempmapdata.map((e) => ProsModel.fromJson(e)).toList();
        notifyListeners();
        ecritureStockageLocale(currentID);
      } else {
        print("Erreur Reception donn??es");
      }
      //code  requetes http
    } catch (e) {
      print(e.toString());
      // generalement pour gerer les erreurs de connectivit??
    }
  }

  Timer? timer;

  repetition() {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 5), (t) {
        print("test ${t.tick}");
      });
    }
  }

  lecturestockageLocale(int currentId) {
    var cle = "${Parametres.keyProspect}_$currentId";

    var locale = stockage.read<String>(cle);
    if (locale != null) {
      var temp = json.decode(locale) as Map;
      stockage_data = temp;
      for (var i in stockage_data.keys) {
       // print("$i");
       // print("${stockage_data[i]}");
      //  print("=====");
      }
      print("stockage_data $cle ${stockage_data.length}");
      //var temp1 = temp.map((e) => ProspectModel.fromJson(e)).toList();
      return temp;
    } else {
      print("Fichier inexistant");
      return {};
    }
  }

  ecritureStockageLocale(int currentId) async {
    var cle = "${Parametres.keyProspect}_$currentId";
    //var temp = data.map((e) => e.toJson()).toList();
    await stockage.write(cle, json.encode(stockage_data));
  }

/* ajoutListValider() {
    var resultat = data.where((e) => e.state == "valider").toList();
    listValider = resultat;
  }

  ajoutListRejeter() {
    var resultat = data.where((e) => e.state == "rejeter").toList();
    listRejeter = resultat;
  }

  ajoutListAtente() {
    var resultat = data.where((e) => e.state == "atente").toList();
    listAtente = resultat;
  }

  ajoutListBrouillon() {
    var resultat = data.where((e) => e.state == "atente").toList();
    listAtente = resultat;
  }

  statut() {
    ajoutListValider();
    ajoutListRejeter();
    ajoutListAtente();
    ajoutListBrouillon();
  }*/
}

void main() async {
  await GetStorage.init();
  var controller = ProspectController();
 // print("1: Longeur liste ${controller.data.length}");
  // controller.recupererDonneesAPI();
 // print("2: Longeur liste ${controller.data.length}");
  repetition();
}
