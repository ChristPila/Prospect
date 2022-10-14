import 'package:http/http.dart' as http;
import 'package:prospect/Tools/Parametres.dart';
import 'package:prospect/models/VilleModel.dart';


class RemoteServicesVilles{
  static getVilles(int? id) async {
    var url=Uri(scheme: Parametres.scheme, host: Parametres.host ,path:'api/villes/province/$id', port: Parametres.port);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode ==200)
    {
      var json = reponse.body;
      return  villeModelFromJson(json);
    }
  }
}