import 'package:http/http.dart' as http;
import 'package:prospect/models/ZoneModel.dart';
import '../utils/Parametres.dart';

class RemoteServicesZone{
  static getZone(int? id) async {
    var url=Uri(scheme: Parametres.scheme, host: Parametres.host ,path:'api/zones/ville/$id', port: Parametres.port);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode ==200)
    {
      var json = reponse.body;
      return  zoneModelFromJson(json);
    }
  }
}