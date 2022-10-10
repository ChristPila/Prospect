import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../Models/UserModel.dart';
import '../Tools/Parametres.dart';
import 'package:get_storage/get_storage.dart';

class AuthentifacationController with ChangeNotifier {

  GetStorage stockage = GetStorage();
  Map<String, dynamic> temp = {};
  UserModel user = UserModel();
  String? token;

  authentifier(Map data) async {

    var headers = {
      'Content-Type': 'application/json'
    };

    var url = Uri(
        scheme: Parametres.scheme,
        host: Parametres.host,
        port: Parametres.port,
        path: Parametres.endPointLogin,
        );
    try {
      var response = await http
          .post(url, body: jsonEncode(data), headers: headers)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200 ) {
        var dataFromApi = response.body;
        var dataFromApi1 = json.decode(dataFromApi);
        token = dataFromApi1['token'];
        stockage.write("token", token!);
        temp = dataFromApi1['user'];
        user=UserModel.fromMap(temp);
        stockage.write("user", user.toMap());
        return data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      print("$e");
      print("$s");
      return null;
    }
  }
}
