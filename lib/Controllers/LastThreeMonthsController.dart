import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Models/LastThreeMonthsModel.dart';
import '../Tools/Parametres.dart';

class LastThreeMonthsController with ChangeNotifier {

  List<LastThreeMonthsModel> lastThreeMonthsList=[];
  GetStorage userToken = GetStorage();
  String? token;

  getReportMonthData() async {
    var url = Uri(
      scheme: Parametres.scheme,
      host: Parametres.host,
      port: Parametres.port,
      path: Parametres.endThreeLastMonths,
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
      lastThreeMonthsList=templist.map((e) => LastThreeMonthsModel.fromJson(e)).toList();
      notifyListeners();
    }
  }
}

