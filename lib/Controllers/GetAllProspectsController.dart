import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Tools/Parametres.dart';

class GetAllProspectsController with ChangeNotifier {

  var numbreAllProspects;
  GetStorage stockage = GetStorage(Parametres.STOCKAGE_VERSION);
  String? token;

  getReportData() async {
    var url = Uri(
      scheme: Parametres.scheme,
      host: Parametres.host,
      port: Parametres.port,
      path: Parametres.endPointGetAllProspects,
    );
    token = stockage.read("token");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200){
      String result = response.body;
      var temp = json.decode(result);
      numbreAllProspects = temp[0]["nombre"];
      stockage.write("getAllProspect", numbreAllProspects);
      notifyListeners();
    }
  }
}

