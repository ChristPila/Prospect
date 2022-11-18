import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Models/LastThreeDaysModel.dart';
import '../Tools/Parametres.dart';


class LastThreeDayController with ChangeNotifier {

  List<LastThreeDaysModel> LastThreeDaysList=[];
  GetStorage userToken = GetStorage(Parametres.STOCKAGE_VERSION);
  String? token;

  getReportData() async {
    try{
      var url = Uri(
        scheme: Parametres.scheme,
        host: Parametres.host,
        port: Parametres.port,
        path: Parametres.endThreeLastDays,
      );
      token = userToken.read("token");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200 ){
        String result = response.body;
        var templist = json.decode(result) as List<dynamic>;
        LastThreeDaysList=templist.map((e) => LastThreeDaysModel.fromJson(e)).toList();
        notifyListeners();
      }
    } on Exception catch (e){
      print(e.toString());
    };
  }
}

