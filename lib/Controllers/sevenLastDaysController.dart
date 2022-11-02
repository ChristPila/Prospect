import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../Models/SevenLastDaysModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Tools/Parametres.dart';
class SevenLastDaysController with ChangeNotifier {

  List<SevenLastDaysModel> SevenLastDaysList=[];
  GetStorage userToken = GetStorage(Parametres.STOCKAGE_VERSION);
  String? token;

  getReportData() async {
    var url = Uri(
      scheme: Parametres.scheme,
      host: Parametres.host,
      port: Parametres.port,
      path: Parametres.endSevenLastDays,
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
      SevenLastDaysList=templist.map((e) => SevenLastDaysModel.fromJson(e)).toList();
      notifyListeners();
      print(response.body);
    }

  }
}