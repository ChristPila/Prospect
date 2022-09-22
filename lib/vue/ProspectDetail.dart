import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prospect/controller/ProspectController.dart';
import '../model/ProspectModel.dart';
import '../utils/utilitaires.dart';
import 'Carte.dart';

class DetailProspect extends StatefulWidget {
  const DetailProspect({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<DetailProspect> createState() => _DetailProspectState();
}

File? imageFile;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prospect Details"),
        centerTitle: true,
        backgroundColor: Utilitaires.DEFAULT_COLOR,
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 15),
          color: Colors.white,
          child: Center(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                margin: const EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromRGBO(143, 134, 143, 0.0)),
                                child: Row(
                                  children: [
                                    Icon(Icons.call_to_action_outlined),
                                    Text("companyName :",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            decoration: TextDecoration.none)),
                                    Spacer(),
                                    Text("${clientrecup.companyName}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            decoration: TextDecoration.none)),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                margin: const EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromRGBO(143, 134, 143, 0.0)),
                                child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    Text("agent :",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            decoration: TextDecoration.none)),
                                    Spacer(),
                                    Text("${clientrecup.agent!.identity}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            decoration: TextDecoration.none)),
                                  ],
                                ),
                              ),
                            ])),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(height: 2),
                    Container(
                      height: 40,
                      child: ListTile(
                        title: Text(
                          "Images",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    imgVue(),
                    SizedBox(height: 2),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(143, 134, 143, 0.0)),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                Text("Commune: ",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                                Spacer(),
                                Text("${clientrecup.commune!.name!}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(143, 134, 143, 0.0)),
                            child: Row(
                              children: [
                                Icon(Icons.house),
                                Text("companyAdress:",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                                Spacer(),
                                Text("${clientrecup.companyAddress!}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(143, 134, 143, 0.0)),
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                Text("companyPhone:",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                                Spacer(),
                                Text("${clientrecup.companyPhone}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(143, 134, 143, 0.0)),
                            child: Row(
                              children: [
                                Icon(Icons.type_specimen_outlined),
                                Text("companyType:",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                                Spacer(),
                                Text("${clientrecup.companyType!.name}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(143, 134, 143, 0.0)),
                            child: Row(
                              children: [
                                Icon(Icons.coffee_maker_rounded),
                                Text("offres:",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                                Spacer(),
                              ],
                            ),
                          ),
                          Wrap(
                            children: clientrecup.offres!.map((e)  {
                              return Container(
                                padding: const EdgeInsets.all(3.0),
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),color: Colors.orangeAccent,
                                ),
                                child: Text("${e.name}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 17,
                                        decoration: TextDecoration.none)),
                              );
                            }) .toList(),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(height: 1),
                          Container(
                            height: 40,
                            child: ListTile(
                              title: Text(
                                "Documents",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          docVue(),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 150),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Utilitaires.DEFAULT_COLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return Carte(title: 'Afficher la carte');
                              }));
                            },
                            child: Text(
                              'Afficher la carte',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  imgVue() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          SizedBox(
            width: 10,
          ),
          imageProfile(),
          SizedBox(
            width: 10,
          ),
          imageProfile(),
          SizedBox(
            width: 10,
          ),
          imageProfile()
        ],
      ),
    );
  }

  docVue() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          SizedBox(
            width: 10,
          ),
          doc(),
          SizedBox(
            width: 10,
          ),
          doc(),
          SizedBox(
            width: 10,
          ),
          doc(),
        ],
      ),
    );
  }

  Widget imageProfile() {
    return imageFile == null
        ? Container(
            width: 140,
            height: 180,
            color: Colors.grey,
          )
        : Container(
            width: 140,
            height: 180,
            child: Image.file(
              imageFile!,
              fit: BoxFit.cover,
            ),
          );
  }

  Widget doc() {
    return imageFile == null
        ? Container(
            width: 140,
            height: 180,
            color: Colors.grey,
          )
        : Container(
            width: 140,
            height: 180,
            child: Image.file(
              imageFile!,
              fit: BoxFit.cover,
            ),
          );
  }
}
