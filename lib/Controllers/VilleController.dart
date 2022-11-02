import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prospect/Tools/Parametres.dart';
import 'package:prospect/Models/VilleModel.dart';



class RemoteServicesVilles{
  static getVilles(int? id) async {
    final dataVille = GetStorage(Parametres.STOCKAGE_VERSION);
    var url=Uri(scheme: Parametres.scheme, host: Parametres.host ,path:'api/villes/province/$id', port: Parametres.port);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode == 200)
    {
      var json = reponse.body;
      return  villeModelFromJson(json);
    } else {
      return [];
    }
  }
}