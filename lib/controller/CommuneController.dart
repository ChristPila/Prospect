import 'package:http/http.dart' as http;
import 'package:prospect/models/CommuneModel.dart';
import 'package:prospect/utils/Parametres.dart';

class RemoteServicesCommune{
  static getCommune(int? id) async {
    var url=Uri(scheme: Parametres.scheme, host: Parametres.host ,path:'api/communes/zone/$id', port: Parametres.port);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode ==200)
    {
      var json = reponse.body;
      return  communeModelFromJson(json);
    }
  }
}