import 'package:http/http.dart' as http;
import 'package:prospect/models/ProvinceModel.dart';

class RemoteServices{
  static getProvinces() async {
    var url=Uri(scheme: "http", host: '10.224.196.172',path:'api/provinces',port: 8000);
    print(url);
    var reponse=await http.get(url);
    if(reponse.statusCode ==200)
    {
      var json = reponse.body;
      return  provinceModelFromJson(json);
    }
  }
}