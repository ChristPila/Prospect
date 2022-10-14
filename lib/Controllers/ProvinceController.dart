import 'package:http/http.dart' as http;
import 'package:prospect/Tools/Parametres.dart';
import 'package:prospect/models/ProvinceModel.dart';

class RemoteServicesProv{
  static getProvinces() async {
    var url=Uri(scheme: Parametres.scheme, host: Parametres.host ,path:Parametres.endPointProvinces, port: Parametres.port);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode ==200)
    {
      var json = reponse.body;
      return  provinceModelFromJson(json);
    }
  }
}