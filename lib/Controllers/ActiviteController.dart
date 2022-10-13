import 'package:prospect/models/ActiviteModel.dart';
import '../utils/Parametres.dart';
import 'package:http/http.dart' as http;

class RemoteServicesAct{
  static getActivity() async {
    var url=Uri(scheme: Parametres.scheme, host: Parametres.host ,path:Parametres.endPointAct, port: Parametres.port);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode ==200)
    {
      var json = reponse.body;
      return  activiteModelFromJson(json);
    }
  }
}