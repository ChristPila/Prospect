import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import 'package:prospect/Models/prosModel.dart';
import 'package:prospect/Tools/Parametres.dart';
import 'package:provider/provider.dart';

import 'DetailProspectPage.dart';
import 'FormulaireProspectPage.dart';
import 'ProgressPage.dart';

class ListeProspectPage extends StatefulWidget {
  String state;

  ListeProspectPage({Key? key, this.state = "0"}) : super(key: key);

  @override
  State<ListeProspectPage> createState() => _ProspectState();
}

class _ProspectState extends State<ListeProspectPage> {
  GetStorage stockage = GetStorage(Parametres.STOCKAGE_VERSION);

  EdgeInsets paddingVal = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
  List<String> listeTypesStatut_ = [
    "Tous",
    'Atente',
    "Valider",
    "Rejeter",
    "Brouillon"
  ];
  Map<String, String> listeTypesStatut = {
    "Tous": "0",
    'En attente': '1',
    "Validé": "2",
    "Rejeté": "3",
    "Brouillon": "4",
  };

  Map<String, String> listeTypesStatut2 = {
    "0": "Tous",
    '1': 'En attente',
    "2": "Validé",
    "3": "Rejeté",
    "4": "Brouillon",
  };
  late String typeStatutSelectionne;

  late String typeStatutSelectionne_int;

  var dataProspectCopie = [];
  bool isapicallprocess = false;
  DateTime? Temps;


  intdata() async {
    var userData = stockage.read('user');
    var currentId = userData['id'];
    await context.read<ProspectController>().recupererDonneesLocales(currentId);
    var listOriginalProspect = context.read<ProspectController>().data;
    //dataProspectCopie = listOriginalProspect;
    if (typeStatutSelectionne_int == "0") {
      dataProspectCopie = listOriginalProspect;
    } else {
      dataProspectCopie = listOriginalProspect
          .where((e) => e.state == typeStatutSelectionne_int)
          .toList();
    }
  //  print(dataProspectCopie.length);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // print("widget.state ${widget.state}");
    typeStatutSelectionne_int = widget.state;
    typeStatutSelectionne = listeTypesStatut2[widget.state] ?? "Tous";
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      intdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressPage(
      child: build2(context),
      inAsyncCall: isapicallprocess,
      opacity: 0.3,
    );
  }

  Widget build2(BuildContext context) {
    // context.read<ProspectController>().statut();
    var listProspect = context.watch<ProspectController>().data;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Parametres.DEFAULT_COLOR,
        title: Text("Liste des prospects (${listProspect.length})"),
        actions: [
          IconButton(
              onPressed: () async {
                intdata();
                setState(() {
                  isapicallprocess = true;
                });
                var userData = stockage.read('user');
                var currentId = userData['id'];
                var value = await context
                    .read<ProspectController>()
                    .recupererDonneesAPI(currentId);
                print('value $value');
                setState(() {
                  isapicallprocess = false;
                });
                if (value != null) {
                  SnackBar(content: Text('Données téléchargées avec succès'));
                } else {
                  SnackBar(content: Text('Echec de la connexion'));
                }
              },
              iconSize: 25,
              icon:   Icon ( Icons.refresh_outlined,
                  color: Colors.white,
                  size: 25),),
          IconButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FormulaireProspectPage();
                }));
              },
              iconSize: 25,
              icon:   Icon ( Icons.add,
                  color: Colors.black,
                  size: 25),),
        ],
      ),
      body: Column(
        children: <Widget>[
          selectionTypeStatut(context),
          listProspectVue(context),
        ],
      ),
    ));
  }

  listProspectVue(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: dataProspectCopie.length,
        shrinkWrap: true,
        separatorBuilder: (ctx, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
         // print("la valeur de l'index est ${index}");
          int taille= dataProspectCopie.length - index -1;
          ProsModel prospect = dataProspectCopie[taille];
          var zones = context.watch<ProspectController>().zones;
          var zoneId = prospect.zoneId;
         // print("2222 ${prospect.companyName}");
          // print(zones);
          // print('$zoneId ====== ${prospect.id}');
          Map? zone_data = zoneId != null ? zones[zoneId] : {};
          var zone_name = zone_data?["name"];

          var villes = context.watch<ProspectController>().villes;
          var villeId = prospect.villeId;
          Map? ville_data = villeId != null ? villes[villeId] : {};
          var ville_name = ville_data?["name"];

          var provinces = context.watch<ProspectController>().provinces;
          var provinceId = prospect.provinceId;
          Map? province_data = provinceId != null ? provinces[provinceId] : {};
          var province_name = province_data?["name"];

          var communes = context.watch<ProspectController>().communes;
          var communeId = prospect.communeId;
          Map? commune_data = communeId != null ? communes[communeId] : {};
          var commune_name = commune_data?["name"];

          var icon = Icons.remove_circle;
          var color = Colors.blue;

          switch (prospect.state) {
            case "2":
              icon = Icons.check;
              color = Colors.green;
              break;

            case "3":
              icon = Icons.close;
              color = Colors.red;
              break;
            case "4":
              icon = Icons.edit_note_rounded;
              color = Colors.grey;
              break;
          }

          return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailProspectPage(
                          data: prospect,
                        ))),
             leading:  Icon(
               icon,
               color: color,
               size: 35,
             ),
            title: Text(
              'Companie : ${prospect.companyName}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'State :${prospect.state}',
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
              trailing: Text(
          "${chronoDyn((prospect.remoteId).toString())}",
          style: TextStyle(color: Colors.black, fontSize: 15),
              )
          );
        },
      ),
    );
  }

  selectionTypeStatut(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 200),
      child: DropdownButton(
        value: typeStatutSelectionne,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: listeTypesStatut.keys.toList().map((String cle) {
          return DropdownMenuItem(
            value: cle,
            child: Text(cle),
          );
        }).toList(),
        onChanged: (String? newValue) {
          typeStatutSelectionne = newValue!;
         // print('$typeStatutSelectionne');
         // print(listeTypesStatut[newValue]);
          typeStatutSelectionne_int = listeTypesStatut[newValue]!;
          var listOriginalProspect = context.read<ProspectController>().data;
          if (typeStatutSelectionne_int == "0") {
            dataProspectCopie = listOriginalProspect;
          } else {
            dataProspectCopie = listOriginalProspect
                .where((e) => e.state == typeStatutSelectionne_int)
                .toList();
          }
          setState(() {});
        },
      ),
    );
  }

  String chronoDyn(String time){
    var inputFormat = DateFormat('dd-MM-yyyy');
    var msg="";
    var now = DateTime.now();
   // print('now $now');
    var timeConvert=int.parse(time );
   // print('timeConvert $timeConvert');
    final DateTime dateProspect = DateTime.fromMillisecondsSinceEpoch(timeConvert );
  //  print ("dateProspect $dateProspect");
    Duration diff = now.difference(dateProspect);
    if (diff.inDays > 7) {
      var outputDate = inputFormat.format(dateProspect);
      msg= '${outputDate}';
    } else if (diff.inDays >= 1) {
      msg= '${diff.inDays} j';
    } else if (diff.inHours >= 1) {
      msg= '${diff.inHours} h';
    } else if (diff.inMinutes >= 1) {
      msg= '${diff.inMinutes} min';
    } else if (diff.inSeconds >= 1) {
      msg= '${diff.inSeconds} sec';
    } else {
      msg= 'maintenant';
    }
    return msg;
  }
}
