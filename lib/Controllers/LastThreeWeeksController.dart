import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Models/LastThreeWeeksModel.dart';
import '../Tools/Parametres.dart';

class LastThreeWeeksController with ChangeNotifier {

  List<LastThreeWeeksModel> lastThreeWeeksList=[];
  GetStorage userToken = GetStorage(Parametres.STOCKAGE_VERSION);
  String? token;

  getReportWeekData() async {
    try{
      var url = Uri(
        scheme: Parametres.scheme,
        host: Parametres.host,
        port: Parametres.port,
        path: Parametres.endThreeLastWeeks,
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
        lastThreeWeeksList=templist.map((e) => LastThreeWeeksModel.fromJson(e)).toList();
        notifyListeners();
      }
    } on Exception catch (e){
      print(e.toString());
    };
  }
}

