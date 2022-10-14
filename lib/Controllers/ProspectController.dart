import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prospect/Tools/Test.dart';
import '../Models/ProspectModel.dart';
import '../Tools/Parametres.dart';
import '../Tools/Utilitaires.dart';
import 'package:http/http.dart' as http;

class ProspectController with ChangeNotifier {
  List<ProspectModel> data = [];
  Map stockage_data = {};
  List<ProspectModel> listValider = [];
  List<ProspectModel> listRejeter = [];
  List<ProspectModel> listAtente = [];
  List<ProspectModel> listBrouillon = [];
  final stockage = GetStorage(Utilitaires.STOCKAGE_VERSION);

  int randomInt() {
    print(Random().nextInt(100 - 0 + 1) + 0);
    return Random().nextInt(100 - 0 + 1) + 0;
  }

  recupererDonneesAPI() async {
    await lecturestockageLocale();
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
          .map((e) => ProspectModel.fromJson(e))
          .toList(); //  conversion des donnees fusionnees en liste de prospect_model
      notifyListeners();
      print(reponse.body);

      print("local_data ${data.length}");
      ecritureStockageLocale();
    } else {
      print("Erreur Reception données");
    }
    notifyListeners();
  }

  verifierStatusDonneeAPI(String remote_id) async {
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
      data = tempmapdata.map((e) => ProspectModel.fromJson(e)).toList();
      notifyListeners();
      ecritureStockageLocale();
    } else {
      print("Erreur Reception données");
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

  Future<Map> lecturestockageLocale() async {
    var locale = stockage.read<String>('PROSPECT');
    if (locale != null) {
      var temp = json.decode(locale) as Map;
      stockage_data = temp;
      //var temp1 = temp.map((e) => ProspectModel.fromJson(e)).toList();
      return temp;
    } else {
      print("Fichier inexistant");
      return {};
    }
  }

  ecritureStockageLocale() async {
    //var temp = data.map((e) => e.toJson()).toList();
    await stockage.write("PROSPECT", json.encode(stockage_data));
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
  print("1: Longeur liste ${controller.data.length}");
  controller.recupererDonneesAPI();
  print("2: Longeur liste ${controller.data.length}");
  repetition();
}
