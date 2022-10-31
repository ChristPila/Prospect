import 'package:flutter/material.dart';
import 'package:prospect/Models/ProspectModel.dart';
import 'package:prospect/models/ProspectModel.dart';
import 'package:provider/provider.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import '../Tools/Parametres.dart';
import '../Views/PiecesJointesPage.dart';
import 'FormulaireProspectPage.dart';

class DetailProspectPage extends StatefulWidget {
  const DetailProspectPage({super.key, required this.data,});

  final ProspectModel data;

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
                    onPressed: () {},
                    icon: Icon(
                      states[clientrecup.state]["icon"],
                      color: states[clientrecup.state]["color"],
                      size: 30,
                    ))
                : clientrecup.state == "4"
                    ? TextButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return FormulaireProspectPage(
                              recup: clientrecup);
                          }));
                        },
                        icon: Icon(Icons.edit_note,
                            color: Colors.white, size: 30),
                        label: Text(""))
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
          Text("${clientrecup.TypeActivities!.name}",
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
          Text("${clientrecup.offres}",
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
          Text("${clientrecup.commune!.zone!.ville!.province!.name}",
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
          Text("${clientrecup.commune!.zone!.ville!.name}",
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
          Text("${clientrecup.commune!.name}",
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
          Text("${clientrecup.commune!.zone!.name}",
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
          Text("${clientrecup.agent!.id}",
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
