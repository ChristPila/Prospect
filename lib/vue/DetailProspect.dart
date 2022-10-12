import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prospect/controller/ProspectController.dart';
import '../model/ProspectModel.dart';
import '../utils/utilitaires.dart';
import 'Dossiers.dart';

class DetailProspect extends StatefulWidget {
  const DetailProspect({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<DetailProspect> createState() => _DetailProspectState();
}

class _DetailProspectState extends State<DetailProspect> {
  @override
  Widget build(BuildContext context) {
    context.read<ProspectController>().statut();
    var listProspect = context.watch<ProspectController>().data;
    ProspectModel clientrecup = ProspectModel();
    for (var i = 0; i < listProspect.length; i++) {
      if (listProspect[i].id.toString() == widget.id) {
        setState(() {
          clientrecup = listProspect[i];
        });
      }
    }
    Map states = {
      "2": {"color": Colors.green, "icon": Icons.check},
      "3": {"color": Colors.red, "icon": Icons.close},
      "4": {"color": Colors.grey, "icon": Icons.edit_note_rounded},
    };
    return Scaffold(
      appBar: AppBar(
          title: const Text("Prospect Details"),
          centerTitle: false,
          backgroundColor: Utilitaires.DEFAULT_COLOR,
          actions: [
            clientrecup.state != "1"
                ? IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                     states[clientrecup.state]["icon"],
                      color: states[clientrecup.state]["color"],
                      size: 30,
                    ))
                : TextButton(
                onPressed: () {
                  context.read<ProspectController>().verifierStatusDonneeAPI(clientrecup.remoteId!);
            },
                child: Text("Verification",style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)))
          ]),
      body: Container(
          padding: const EdgeInsets.only(top: 10),
          color: Colors.white,
          child: Center(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          //Icon(Icons.call_to_action_outlined),
                          Text("Companie:",
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                          Container(
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
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Container(
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
                                Text("${clientrecup.companyType?.name}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Container(
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
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Container(
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
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.offline_pin_outlined),
                                Text("Offres:",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none)),
                                Spacer(),
                              ],
                            ),
                          ),
                          Wrap(
                            children:   clientrecup.offres!.map((e) {
                              return Container(
                                padding: const EdgeInsets.all(2.0),
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.blueAccent,
                                ),
                                child: Text("${e.name}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none)),
                              );
                            }).toList(),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Container(
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
                                Text(
                                    "${clientrecup.commune?.zone!.ville!.province!.name}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),

                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Container(
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
                                Text(
                                    "${clientrecup.commune?.zone!.ville!.name}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Container(
                              padding: EdgeInsets.only(left: 3),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          Text("Commune: ",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  decoration:
                                                      TextDecoration.none)),
                                          Spacer(),
                                          Text("${clientrecup.commune?.name!}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none)),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(height: 1),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          Text("Zone :",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  decoration:
                                                      TextDecoration.none)),
                                          Spacer(),
                                          Text(
                                              "${clientrecup.commune?.zone!.name}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none)),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(height: 1),
                                    Text("Localisation :",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none)),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.map),
                                          Text("Latitude , Longitude:",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  decoration:
                                                      TextDecoration.none)),
                                          Spacer(),
                                          Text(
                                              "${clientrecup.latitude};${clientrecup.longitude}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none)),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(height: 1),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person),
                                          Text("Agent :",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  decoration:
                                                      TextDecoration.none)),
                                          Spacer(),
                                          Text("${clientrecup.agent?.identity}",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none)),
                                        ],
                                      ),
                                    ),
                                  ])),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /*  Container(
                           padding: const EdgeInsets.only(left: 100),
                         ),*/
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, top: 10, right: 15, bottom: 10),
                                child: FlatButton.icon(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return Dossiers(clientrecup: clientrecup);
                                    }));
                                  },
                                  icon: Icon(Icons.folder_copy),
                                  label: Text(
                                    "Pieces Jointes",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  color: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: EdgeInsets.only(
                                      left: 20, top: 8, right: 40, bottom: 8),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
