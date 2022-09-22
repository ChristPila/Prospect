import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../model/ProspectModel.dart';
import '../utils/fakedata.dart';
import '../utils/utilitaires.dart';
import '../vue/test.dart';

class ProspectController with ChangeNotifier {
  List<ProspectModel> data = [];
  List<ProspectModel> listValider = [];
  List<ProspectModel> listRejeter = [];
  List<ProspectModel> listAtente = [];
  final stockage = GetStorage(Utilitaires.STOCKAGE_VERSION);

  int randomInt() {
    print(Random().nextInt(100 - 0 + 1) + 0);
    return Random().nextInt(100 - 0 + 1) + 0;
  }

  recupererDonneesAPI() async {
    data = await lecturestockageLocale();
    // recuperer API laravel
    var donneesAPI = fakeData.map((e) => ProspectModel.fromJson(e)).toList();

    print(donneesAPI.map((e) => e.toJson()).toList());
    data.addAll(donneesAPI);
    print("local_data ${data.length}");

    /*data.sort((a, b) => a.zone!.compareTo(b.zone!));
    print('zone ascending order: ${data.toString()}');*/
    ecritureStockageLocale();
    notifyListeners();
  }

  Timer? timer;
  repetition(){

    if (timer == null){
      timer = Timer.periodic(Duration(seconds: 5), (t) {
        print("test ${t.tick}");
      });
    }
  }

  Future<List<ProspectModel>> lecturestockageLocale() async {
    var locale = stockage.read<String>('PROSPECT');
    if (locale != null) {
      var temp = json.decode(locale) as List<dynamic>;
      var temp1 = temp.map((e) => ProspectModel.fromJson(e)).toList();
      return temp1;
    } else {
      print("Fichier inexistant");
      return [];
    }
  }

  ecritureStockageLocale() async {
    var temp = data.map((e) => e.toJson()).toList();
    await stockage.write("PROSPECT", json.encode(temp));
  }

  ajoutListValider() {
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

  statut() {
    ajoutListValider();
    ajoutListRejeter();
    ajoutListAtente();
  }
}

void main() async {
  await GetStorage.init();
  var controller = ProspectController();
  print("1: Longeur liste ${controller.data.length}");
  controller.recupererDonneesAPI();
  print("2: Longeur liste ${controller.data.length}");
  repetition();
}
