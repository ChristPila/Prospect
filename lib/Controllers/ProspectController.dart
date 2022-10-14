import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:gallery_saver/files.dart';
import 'package:http/http.dart' as http;
import 'package:prospect/Models/ProspectModel.dart';

import '../Models/prosModel.dart';
import '../utils/Parametres.dart';

class ProspectController with ChangeNotifier {
  // liste initiale
  List<ProsModel> listProspects = [];
  // focntion pour ajouter un prospect
  void ajouterProspect(ProsModel data) {
    data.id = listProspects.length + 1;
    listProspects.add(data);
    notifyListeners();
  }

  Future<dynamic> submitProspect(dynamic data) async{
    var res = json.encode(data);
    var header = {
      "Content-Type":"application/json"
    };
    var url = Uri.http('10.20.20.150:8081', Parametres.endPointProspect);
    var response = await http.post(
        url,
        body: res,
        headers: header
    );
    print(url);
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }
    return response.statusCode;
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
