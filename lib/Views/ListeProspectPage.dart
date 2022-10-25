import 'package:flutter/material.dart';
import 'package:prospect/Tools/Parametres.dart';
import 'package:provider/provider.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import 'DetailProspectPage.dart';
import 'ProgressPage.dart';

class ListeProspectPage extends StatefulWidget {
  const ListeProspectPage({Key? key}) : super(key: key);

  @override
  State<ListeProspectPage> createState() => _ProspectState();
}

class _ProspectState extends State<ListeProspectPage> {
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
  String typeStatutSelectionne = 'Tous';
  String typeStatutSelectionne_int = '0';

  var dataProspectCopie = [];
  bool isapicallprocess = false;

  intdata() async {
    // await context.read<ProspectController>().recupererDonneesAPI();
    var listOriginalProspect =
        context.read<ProspectController>().data;
    dataProspectCopie = listOriginalProspect;
    print(dataProspectCopie.length);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProspectController>().recupererDonneesAPI();
      //context.read<ProspectController>().verifierStatusDonneeAPI("remoteId");
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

  @override
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
                var value = await context
                    .read<ProspectController>()
                    .recupererDonneesAPI();
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
              iconSize: 40,
              icon: Icon(Icons.refresh_outlined)),
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
      child: ListView.builder(
        itemCount: dataProspectCopie.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var prospect = dataProspectCopie[index];
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
            leading: Icon(
              icon,
              color: color,
              size: 35,
            ),
            title: Text(
              'state : ${prospect.state}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Companie: ${prospect.companyName}\nZone: ${prospect.commune}',
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          );
        },
      ),
    );
  }

  listStatutAtente(BuildContext context, List listAtente) {
    return ListView.builder(
      itemCount: listAtente.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                padding: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailProspectPage(
                                data: listAtente[index],
                              ))),
                  leading: Icon(
                    Icons.remove_circle,
                    color: Colors.blue,
                    size: 35,
                  ),
                  title: Text(
                    'state : ${listAtente[index].state}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Companie: ${listAtente[index].companyName}\nZone: ${listAtente[index].zone}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                )));
      },
    );
  }

  dataView(BuildContext context) {
    var data = context.watch<ProspectController>().data;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var couleur = index % 2 == 0
              ? Colors.transparent
              : Colors.grey.withOpacity(0.3);
          var prospect = data[index];
          return Container(
            color: couleur,
            child: ListTile(
              leading: Icon(
                Icons.edit_note_rounded,
                size: 30,
              ),
              title: Text(
                'Companie: ${prospect.companyName}',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              subtitle: Text(
                'statut :${prospect.state}\nZone: 1',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
            ),
          );
        });
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
          print('$typeStatutSelectionne');
          print(listeTypesStatut[newValue]);
          typeStatutSelectionne_int = listeTypesStatut[newValue]!;
          var listOriginalProspect =
              context.read<ProspectController>().data;
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
}
