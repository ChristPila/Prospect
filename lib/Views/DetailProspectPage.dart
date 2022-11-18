import 'package:flutter/material.dart';
import 'package:prospect/Models/prosModel.dart';
import 'package:provider/provider.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import '../Tools/Parametres.dart';
import '../Views/PiecesJointesPage.dart';
import 'FormulaireProspectPage.dart';

class DetailProspectPage extends StatefulWidget {
  final ProsModel data;
  const DetailProspectPage({super.key, required this.data,});



  @override
  State<DetailProspectPage> createState() => _DetailProspectPageState();
}

class _DetailProspectPageState extends State<DetailProspectPage> {
  ProsModel clientrecup = ProsModel();

  @override
  void initState() {
    super.initState();
    clientrecup = widget.data;
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      /*if(!mounted) return;
      var listProspect = context.read<ProspectController>().data;
      for (var i = 0; i < listProspect.length; i++) {
        if (listProspect[i].id.toString() == widget.id) {
          setState(() {
            clientrecup = listProspect[i];
            print("clientrecup ${clientrecup.toJson()}");
          });
        }
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ProspectController>().statut();

    Map states = {
      "2": {"color": Colors.green, "icon": Icons.check},
      "3": {"color": Colors.red, "icon": Icons.close},
      "4": {"color": Colors.grey, "icon": Icons.edit_note_rounded},
    };
    return Scaffold(
      appBar: AppBar(
          title: const Text("DetailsProspect"),
          centerTitle: false,
          backgroundColor: Parametres.DEFAULT_COLOR,
          actions: [
            clientrecup.state != "1"
                ? IconButton(
                    onPressed: () {
                      if(clientrecup.state == "4"){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                              return FormulaireProspectPage(recup: clientrecup);
                            }));
                      };

                    },
                    icon: Icon(
                      states[clientrecup.state]["icon"],
                      color: states[clientrecup.state]["color"],
                      size: 30,
                    ))
                : TextButton.icon(
                        onPressed: () {
                          context
                              .read<ProspectController>()
                              .verifierStatusDonneeAPI(clientrecup.remoteId!);
                        },
                        icon: Icon(Icons.rotate_right_sharp,
                            color: Colors.white, size: 30),
                        label: Text(""))
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1,
            ),
            companySectionTitreVue(),
            companyNomVue(),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 0.5,
            ),
            companytype(),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 0.5,
            ),
            companyadresse(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            companyphone(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            companyoffre(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            companyprovince(),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 0.5,
            ),
            companyville(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            companycommune(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            companyzone(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            localisation1(),
            localisation2(),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 0.5,
            ),
            agent(),
            Divider(thickness: 1),
            SizedBox(
              height: 0.5,
            ),
            boutonpiecesjointes()
          ],
        ),
      ),
    );
  }

  companySectionTitreVue() {
    return Text("Companie:",
        style: const TextStyle(
            color: Colors.black87,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none));
  }

  companyNomVue() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text("Nom:",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${clientrecup.companyName}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companytype() {
   var activity = context.watch<ProspectController>().activity;
    var activityId = clientrecup.typeActivitiesId;
    Map? activity_data = activityId != null ? activity[activityId]:{};
    var activity_name = activity_data?["name"];

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          //Icon(Icons.type_specimen_outlined),
          Text("Type:",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${activity_name}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companyadresse() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.house),
          Text("Adresse:",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${clientrecup.companyAddress}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companyphone() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.phone),
          Text("Telephone:",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${clientrecup.companyPhone}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companyoffre() {
    var offre = context.watch<ProspectController>().offres;
    var offresId = clientrecup.offerId;
    Map? offres_data = offresId != null ? offre[offresId] : {};
    var offres_name = offres_data?["name"];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.offline_pin_outlined),
          Text("Offres:",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${offres_name}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companyprovince() {
    var provinces = context.watch<ProspectController>().provinces;
    var provinceId = clientrecup.provinceId;
    Map? province_data = provinceId != null ? provinces[provinceId] : {};
    var province_name = province_data?["name"];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.location_on),
          Text("Province :",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${province_name}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companyville() {
    var villes = context.read<ProspectController>().villes;
    var villeId = clientrecup.villeId;
    Map? ville_data = villeId != null ? villes[villeId] : {};
    var ville_name = ville_data?["name"];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.location_on),
          Text("Ville :",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${ville_name}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companycommune() {
    var communes = context.watch<ProspectController>().communes;
    var communeId = clientrecup.communeId;
    Map? commune_data = communeId != null ? communes[communeId] : {};
    var ville_name = commune_data?["name"];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.location_on),
          Text("Commune: ",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${ville_name}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  companyzone() {
    var zones = context.watch<ProspectController>().zones;
    var zoneid = clientrecup.zoneId;
    Map? commune_data = zoneid != null ? zones[zoneid] : {};
    var zone_name = commune_data?["name"];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.location_on),
          Text("Zone :",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${zone_name}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  localisation1() {
    return Text("Localisation :",
        style: const TextStyle(
            color: Colors.black87,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none));
  }

  localisation2() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.map),
          Text("Latitude , Longitude:",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${clientrecup.latitude};${clientrecup.longitude}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  agent() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.person),
          Text("Agent :",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  decoration: TextDecoration.none)),
          Spacer(),
          Text("${clientrecup.agentId}",
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  boutonpiecesjointes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
          child: TextButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return PiecesJointesPage(clientrecup: clientrecup);
              }));
            },
            icon: Icon(Icons.folder_copy, color: Colors.white),
            label: Text("Pieces Jointes"),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                )),
          ),
        )
      ],
    );
  }
}
