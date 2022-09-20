import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prospect/controller/ProspectController.dart';
import '../model/ProspectModel.dart';
import '../utils/utilitaires.dart';

class DetailProspect extends StatefulWidget {
  const  DetailProspect({super.key, required this.id,});
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
      if (listProspect[i].id.toString()==widget.id) {
        setState(() {
          clientrecup=listProspect[i];
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProspectDetails"),
        centerTitle: true,
        backgroundColor: Utilitaires.DEFAULT_COLOR,
      ),


      body: Container(
          padding: const EdgeInsets.only(top: 150),
          color: Colors.white,
          child: Center(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("agentId: ${clientrecup.agent!.id!}", style: const TextStyle(color: Colors.black87,fontSize: 17,decoration: TextDecoration.none)),
                    Text("Commune: ${clientrecup.commune!.name!}", style: const TextStyle(color: Colors.black87,fontSize: 17,decoration: TextDecoration.none)),
                    Text("companyAdress: ${clientrecup.companyAddress!}", style: const TextStyle(color: Colors.black87,fontSize: 17,decoration: TextDecoration.none)),
                    Text("companyName: ${clientrecup.companyName}", style: const TextStyle(color: Colors.black87,fontSize: 17,decoration: TextDecoration.none)),
                    Text("companyPhone: ${clientrecup.companyPhone}", style: const TextStyle(color: Colors.black87,fontSize: 17,decoration: TextDecoration.none)),
                    Text("piecesjointes: ${clientrecup.piecesjointes!.path}", style: const TextStyle(color: Colors.black87,fontSize: 17,decoration: TextDecoration.none)),
                    // Text("State: ${clientrecup.state}", style: const TextStyle(color: Utilitaires.DEFAULT_COLOR,fontSize: 17,decoration: TextDecoration.none)),
                    // Text("Ville: ${clientrecup.ville}", style: const TextStyle(color: Utilitaires.DEFAULT_COLOR,fontSize: 17,decoration: TextDecoration.none)),
                    // Text("Zone: ${clientrecup.zone}", style: const TextStyle(color: Utilitaires.DEFAULT_COLOR,fontSize: 17,decoration: TextDecoration.none)),
                    // Text("Offer: ${clientrecup.offer}", style: const TextStyle(color: Utilitaires.DEFAULT_COLOR,fontSize: 1,decoration: TextDecoration.none)),

                  ],
                )
              ],
            ),
          )),

    );
  }
}