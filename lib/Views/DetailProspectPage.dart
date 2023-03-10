import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prospect/Controllers/FormulaireProspectController.dart';
import 'package:prospect/Models/prosModel.dart';
import 'package:provider/provider.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import '../Tools/Parametres.dart';
import '../Views/PiecesJointesPage.dart';
import 'FormulaireProspectPage.dart';

class DetailProspectPage extends StatefulWidget {
  final ProsModel data;

  const DetailProspectPage({super.key, required this.data});



  @override
  State<DetailProspectPage> createState() => _DetailProspectPageState();
}

class _DetailProspectPageState extends State<DetailProspectPage> {
  ProsModel clientrecup = ProsModel();

  @override
  void initState() {
    super.initState();
    clientrecup = widget.data;
    print(clientrecup.toJson());
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

                        Navigator.push(context,
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
                              .verifierStatusDonneeAPI(clientrecup.remoteId!,clientrecup.agentId!);
                        },
                        icon: Icon(Icons.rotate_right_sharp,
                            color: Colors.black, size: 30),
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
            time(),
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
    var name = clientrecup.companyName == null ?"Nom rempli" : clientrecup.companyName;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [
            Text("Nom: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${name}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companytype() {
    var formCtrl = context.watch<FormulaireProspectController>();
    Map typeEntrep = formCtrl.mapActivities;
    var activitySelectionne = typeEntrep[clientrecup?.typeActivitiesId.toString()];
    var activityText = activitySelectionne == null ? "Non selectionn??" : activitySelectionne['name'];

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [
            Text("Type: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${activityText}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companyadresse() {
    var Adresse = clientrecup.companyAddress == null ?"Nom rempli" : clientrecup.companyAddress;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [Icon( Icons.add_reaction,
            color: Colors.orange,
            size: 25),
            Text("Adresse: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${Adresse}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companyphone() {
    var Phone = clientrecup.companyPhone == null ?"Nom rempli" : clientrecup.companyPhone;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [Icon( Icons.phone,
              color: Colors.orangeAccent,
              size: 25),
            Text("Telephone: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${Phone}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companyoffre() {
    var formCtrl = context.watch<FormulaireProspectController>();
    Map offres = formCtrl.mapOffres;
    var offreSelectionne = offres[clientrecup?.offerId.toString()];
    var offreText = offreSelectionne == null ? "Non selectionn??" : offreSelectionne['name'];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [Icon( Icons.offline_pin_outlined,
              color: Colors.green,
              size: 25),
            Text("Offre: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${offreText}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companyprovince() {
    var formCtrl = context.watch<FormulaireProspectController>();
    Map provinces = formCtrl.mapProvinces;
    var provinceSelectionne = provinces[clientrecup?.provinceId.toString()];
    var provinceText = provinceSelectionne == null ? "Non Selectionn??e" : provinceSelectionne['name'];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [Icon( Icons.local_airport,
              color: Colors.blueAccent,
              size: 25),
            Text("Province: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${provinceText}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companyville() {
    var formCtrl = context.watch<FormulaireProspectController>();
    Map villes = formCtrl.mapVilles;
    var villeSelectionne = villes[clientrecup?.villeId.toString()];
    var villeText = villeSelectionne == null ? "Non Selectionn??e" : villeSelectionne['name'];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [
           Icon ( Icons.location_city,
                color: Colors.redAccent,
                size: 25),
            Text("Ville :",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),
          ],)),

          //Spacer(),
          Flexible(
            child: Text("${villeText}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companycommune() {
    var formCtrl = context.watch<FormulaireProspectController>();
    Map communes = formCtrl.mapCommunes;
    var communeSelectionne = communes[clientrecup?.communeId.toString()];
    var communeText =    communeSelectionne == null ? "Non Selectionn??e" : communeSelectionne['name'];

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [  Icon ( Icons.cabin_outlined,
              color: Colors.green,
              size: 25),
            Text("Commune: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${communeText}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  companyzone() {
    var formCtrl = context.watch<FormulaireProspectController>();
    Map zones = formCtrl.mapZones;
    var communeSelectionne = zones[clientrecup?.zoneId.toString()];
    var zoneText =    communeSelectionne == null ? "Non Selectionn??e" : communeSelectionne['name'];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [  Icon ( Icons.location_on,
              color: Colors.red,
              size: 25),
            Text("Zone: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${zoneText}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
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
    var localisation= clientrecup?.longitude != null
    ? "Captur??"
        : "Non Captur??";
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [   Icon ( Icons.map,
              color: Colors.green,
              size: 25),
            Text("Latitude, Longitude: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${localisation}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }

  agent() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [   Icon ( Icons.person,
              color: Colors.lightBlue,
              size: 25),
            Text("Agent: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${clientrecup.agentId}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
        ],
      ),
    );
  }
  time(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child: Row(children: [   Icon ( Icons.timer,
              color: Colors.lightBlue,
              size: 25),
            Text("Date de cr??ation: ",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    decoration: TextDecoration.none)),],)),

          //Spacer(),
          Flexible(
            child: Text("${chronoDyn((clientrecup.remoteId).toString())}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          ),
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
  String chronoDyn(String time){
    var inputFormat = DateFormat('dd-MM-yyyy hh:mm a sss');
    var msg="";
    var now = DateTime.now();
   // print('now $now');
    var timeConvert=int.parse(time );
  //  print('timeConvert $timeConvert');
    final DateTime dateProspect = DateTime.fromMillisecondsSinceEpoch(timeConvert );
  //  print ("dateProspect $dateProspect");
    Duration diff = now.difference(dateProspect);
    if (diff.inDays > 7) {
      var outputDate = inputFormat.format(dateProspect);
      msg= '${outputDate}';
    } else if (diff.inDays >= 1) {
      msg= '${diff.inDays} j';
      var outputDate = inputFormat.format(dateProspect);
      msg= '${outputDate}';
    } else if (diff.inHours >= 1) {
      msg= '${diff.inHours} h';
      var outputDate = inputFormat.format(dateProspect);
      msg= '${outputDate}';
    } else if (diff.inMinutes >= 1) {
      msg= '${diff.inMinutes} min';
      var outputDate = inputFormat.format(dateProspect);
      msg= '${outputDate}';
    } else if (diff.inSeconds >= 1) {
      msg= '${diff.inSeconds} sec';
      var outputDate = inputFormat.format(dateProspect);
      msg= '${outputDate}';
    } else {
      msg= 'maintenant';
    }
    return msg;
  }
}
