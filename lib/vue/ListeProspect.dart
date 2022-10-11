import 'package:flutter/material.dart';
import 'package:prospect/model/ProspectModel.dart';
import 'package:provider/provider.dart';
import 'package:prospect/controller/ProspectController.dart';
import 'package:prospect/vue/ProspectDetail.dart';
import '../utils/utilitaires.dart';
import 'ProspectDetail.dart';

class ListeProspect extends StatefulWidget {
  const ListeProspect({Key? key}) : super(key: key);

  @override
  State<ListeProspect> createState() => _ProspectState();
}




class _ProspectState extends State<ListeProspect> {
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

  List<ProspectModel> dataProspectCopie = [];

  intdata() async {
   // await context.read<ProspectController>().recupererDonneesAPI();
    List<ProspectModel> listOriginalProspect =
        context.read<ProspectController>().data;
    dataProspectCopie = listOriginalProspect;
    print(dataProspectCopie.length);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await context.read<ProspectController>().recupererDonneesAPI();
      //context.read<ProspectController>().verifierStatusDonneeAPI("remoteId");
      intdata();

    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProspectController>().statut();
    List<ProspectModel> listProspect = context.watch<ProspectController>().data;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Utilitaires.DEFAULT_COLOR,
        title: Text("ProspectsStorage (${listProspect.length})"),
        actions: [
          IconButton(
              onPressed: () {
                intdata();
                context.read<ProspectController>().recupererDonneesAPI();
              },
              iconSize: 40,
              icon: Icon(Icons.refresh_outlined)),
        ],
      ),
      body: Column(
        children: <Widget>[
          selectionTypeStatut(context),
          Expanded(
            child: listProspectVue(context),
          ),
        ],
      ),
    ));
  }

  /*int randomInt() {
    print(Random().nextInt(100 - 0 + 1) + 0);
    return Random().nextInt(100 - 0 + 1) + 0;
  }*/
  /*listStatutValider(BuildContext context, List listValider) {
    return ListView.builder(
      itemCount: listValider.length,
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
                      builder: (context) =>
                          DetailProspect(id: listValider[index].id.toString()))),
              leading: const Icon(
                Icons.remove_circle,
                color: Colors.green,
                size: 35,
              ),
              title: Text(
                'state : ${listValider[index].state}',
                style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold,),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "Companie: ${listValider[index].companyName}\nZone: ${listValider[index].zone}",
                      style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(width: 20),
                  const InkWell(onTap: null, child: Icon(Icons.mode))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  listStatutBrouillon(BuildContext context, List listBrouillon) {
    return ListView.builder(
      itemCount: listBrouillon.length,
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
                      builder: (context) =>
                          DetailProspect(id: listBrouillon[index].id.toString()))),
              leading: const Icon(
                Icons.note,
                color: Colors.grey,
                size: 35,
              ),
              title: Text(
                'state : ${listBrouillon[index].state}',
                style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold,),
              ),
              subtitle: Row(
                children: [
                  Text(
                    'Companie: ${listBrouillon[index].companyName} \nZone: ${listBrouillon[index].zone}',
                      style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(width: 20),
                  const InkWell(onTap: null, child: Icon(Icons.mode))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  listStatutRejeter(BuildContext context, List listRejeter) {
    return ListView.builder(
      itemCount: listRejeter.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailProspect(
                        id: listRejeter[index].id.toString(),
                      ))),
          leading: const Icon(
            Icons.remove_circle,
            color: Colors.red,
            size: 35,
          ),
          title: Text(
            'state : ${listRejeter[index].state}',
            style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold,),
          ),
          subtitle: Text(
            'Companie : ${listRejeter[index].companyName} \nZone: ${listRejeter[index].zone}',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        );
      },
    );
  }
*/
  listProspectVue(BuildContext context) {
    return ListView.builder(
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
                  builder: (context) => DetailProspect(
                        id: prospect.id.toString(),
                      ))),
          leading: Icon(
            icon,
            color: color,
            size: 35,
          ),
          title: Text(
            'state : ${prospect.state}',
            style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold,),
          ),
          subtitle: Text(
            'Companie: ${prospect.companyName}\nZone: ${prospect.commune?.zone?.name}',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        );
      },
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
                          builder: (context) => DetailProspect(
                                id: listAtente[index].id.toString(),
                              ))),
                  leading: Icon(
                    Icons.remove_circle,
                    color: Colors.blue,
                    size: 35,
                  ),
                  title: Text(
                    'state : ${listAtente[index].state}',
                    style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold,),
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
          List<ProspectModel> listOriginalProspect =
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

