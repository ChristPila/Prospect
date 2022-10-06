import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../Models/UserModel.dart';
import '../Tools/Parametres.dart';

class AuthentifacationController with ChangeNotifier {

  Authentification? user;
  String? token;

  get context => null;

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
      print(response.body);
      if (response.statusCode == 200 ) {
        token = response.body;
        var data = Authentification.fromJson({"id":1, "name":"odc", "email":"odc@odc.com", "role":"agent"});
        user = data;
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
