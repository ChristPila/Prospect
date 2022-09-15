import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../model/ProspectModel.dart';
import '../utils/utilitaires.dart';
import '../vue/test.dart';


class ProspectController with ChangeNotifier{
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
    data= await lecturestockageLocale();
    // recuperer API laravel

    var donneesAPI = [
      ProspectModel(id:randomInt(), location:"gkk",agentId:1, province:2, ville:1, zone:"Tshangu", commune:1, companyName:1,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456789, offer:1, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"atente"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:2, province:3, ville:2, zone:"Lukunga", commune:2, companyName:2,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456785, offer:2, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"atente"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:3, province:4, ville:3, zone:"Mont-Amba", commune: 3, companyName:3,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456786, offer:3, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"atente"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:4, province:5, ville:4, zone:"Kasuku", commune: 4, companyName:4,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456787, offer:4, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"atente"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:5, province:6, ville:5, zone:"Mikelenge", commune: 5, companyName:5,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456788, offer:5, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"valider"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:6, province:7, ville:5, zone:"Lukunga", commune: 5, companyName:6,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456788, offer:5, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"valider"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:7, province:8, ville:5, zone:"Mikelenge", commune: 5, companyName:7,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456788, offer:5, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"rejeter"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:8, province:9, ville:5, zone:"Tshangu", commune: 5, companyName:8,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456788, offer:5, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"valider"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:8, province:9, ville:5, zone:"Kasuku", commune: 5, companyName:10,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456788, offer:5, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"rejeter"),
      ProspectModel(id:randomInt(), location:"gkk",agentId:8, province:9, ville:5, zone:"Tshangu", commune: 5, companyName:9,  companyAdress:"ffggg", companyType:"ffg", companyPhone:123456788, offer:5, visuel1:"fdf", visuel2:"rrtr", document1:"fghhh", document2:"gfghf", signature:"ttgtgt", state:"rejeter"),
    ];
       data.addAll(donneesAPI);
      print("local_data ${data.length}");

    data.sort((a, b) => a.zone!.compareTo(b.zone!));
    print('zone ascending order: ${data.toString()}');
      ecritureStockageLocale();
      notifyListeners();
  }
  /*Timer? timer;
  repetition(){

    if (timer == null){
      timer = Timer.periodic(Duration(seconds: 5), (t) {
        print("test ${t.tick}");
      });
    }
  }*/

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
  statut(){
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