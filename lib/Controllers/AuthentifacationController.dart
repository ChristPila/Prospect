import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../Models/UserModel.dart';
import '../Tools/Parametres.dart';
import 'package:get_storage/get_storage.dart';

class AuthentifacationController with ChangeNotifier {

  GetStorage stockage = GetStorage();
  AuthentificationModel? user;
  String? token;

  Authentifier(Map data) async {
    var access = Parametres.ROOT;
    var byte = utf8.encode(access);

    var headers = {
      'authorization': 'Basic ' + base64Encode(byte),
      'Content-Type': 'application/json'
    };

    var url = Uri(
        scheme: Parametres.scheme,
        host: Parametres.host,
        path: Parametres.endPointLogin,
        port: Parametres.port);
    try {
      var response = await http
          .post(url, body: jsonEncode(data), headers: headers)
          .timeout(Duration(seconds: 5));
      print(response.statusCode);
      print(response.reasonPhrase);
      if (response.statusCode == 200 ) {
        var dataUrl = response.body;
        var dataUrl1 = json.decode(dataUrl);
        print(dataUrl1);
        token = dataUrl1['token'];
        print('voici le token => $token');
        stockage.write("token", token!.toString());
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
