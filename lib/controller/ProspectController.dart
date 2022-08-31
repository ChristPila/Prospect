import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import '../model/ProspectModel.dart';

class ProspectController {
  List<ProspectModel> data = [];
  final stockage = GetStorage();

  recupererDonneesAPI() async {
    data=await lecturestockageLocale();
    // recuperer API laravel
    var donneesAPI = [
      ProspectModel(id:1, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:2, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:3, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:4, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:5, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:6, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:7, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:8, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
      ProspectModel(id:9, nomPointVent: "cabine",agentTerrain: "vicky", phone: 123456789, progression: "ghfghfgfdfg", ville: "kinshasa", detail: "gff"),
    ];
    data.addAll(donneesAPI);
    print("local_data ${data.length}");
    ecritureStockageLocale();
  }

  Future<List<ProspectModel>> lecturestockageLocale()  async {

    var locale= stockage.read<String>('PROSPECT');
    if(locale!=null){
      var temp = json.decode(locale) as List<dynamic>;
      var temp1= temp.map((e) => ProspectModel.fromJson(e)).toList();
      return temp1;
    } else {
      print("Fichier inexistant");
      return [];
    }
  }

  ecritureStockageLocale() async {
    var temp = data.map((e) => e.toJson()).toList();

    /*
    POUR FLUTTER
     */
    stockage.write("PROSPECT", json.encode(temp));
  }
}

main() async {
   await GetStorage.init();
  var controller = ProspectController();
  print("1: Longeur liste ${controller.data.length}");

  controller.recupererDonneesAPI();
  print("2: Longeur liste ${controller.data.length}");
}