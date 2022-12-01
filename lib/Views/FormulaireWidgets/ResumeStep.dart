import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../Controllers/FormulaireProspectController.dart';
import '../../Models/prosModel.dart';
import '../../Tools/Parametres.dart';

class ResumeStep extends StatefulWidget {
  final ProsModel? prospect;

  const ResumeStep({super.key, this.prospect});

  @override
  State<ResumeStep> createState() => _ResumeStepState();
}

class _ResumeStepState extends State<ResumeStep> {
  GetStorage stockage = GetStorage(Parametres.STOCKAGE_VERSION);

  @override
  Widget build(BuildContext context) {
    var prospect = widget.prospect;

    var formCtrl = context.watch<FormulaireProspectController>();

    Map typeEntrep = formCtrl.mapActivities;
    var activitySelectionne = typeEntrep[prospect?.typeActivitiesId.toString()];
    var activityText =
        activitySelectionne == null ? "" : activitySelectionne['name'];

    Map offres = formCtrl.mapOffres;
    var offreSelectionne = offres[prospect?.offerId.toString()];
    var offreText = offreSelectionne == null ? "" : offreSelectionne['name'];

    Map provinces = formCtrl.mapProvinces;
    var provinceSelectionne = provinces[prospect?.provinceId.toString()];
    var provinceText =
        provinceSelectionne == null ? "" : provinceSelectionne['name'];

    Map villes = formCtrl.mapVilles;
    var villeSelectionne = villes[prospect?.villeId.toString()];
    var villeText = villeSelectionne == null ? "" : villeSelectionne['name'];

    Map zones = formCtrl.mapZones;
    var zoneSelectionne = zones[prospect?.zoneId.toString()];
    var zoneText = zoneSelectionne == null ? "" : zoneSelectionne['name'];

    Map communes = formCtrl.mapCommunes;
    var communeSelectionne = communes[prospect?.communeId.toString()];
    var communeText =
        communeSelectionne == null ? "" : communeSelectionne['name'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: MediaQuery.of(context).size.height - 250,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            afficheLigne(
                title: "Nom Compagnie", value: "${prospect?.companyName}"),
            afficheLigne(
                title: "Adresse Compagnie",
                value: "${prospect?.companyAddress}"),
            afficheLigne(
                title: "Contact Compagnie", value: "${prospect?.companyPhone}"),
            afficheLigne(title: "Type d'activité", value: "$activityText"),
            afficheLigne(title: "Offres", value: "$offreText"),
            SizedBox(
              height: 20,
            ),
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: (1 / .6),
                crossAxisSpacing: 6,
                physics: ClampingScrollPhysics(),
                children: [
                  localisationVue(
                      icon: Icon(Icons.local_airport,
                          color: Colors.deepOrangeAccent),
                      title: "Province",
                      value: provinceText),
                  localisationVue(
                      icon: Icon(
                        Icons.route,
                        color: Colors.green,
                      ),
                      title: "Ville",
                      value: villeText),
                  localisationVue(
                      icon: Icon(
                        Icons.roofing,
                        color: Colors.orange,
                      ),
                      title: "Zone",
                      value: zoneText),
                  localisationVue(
                      icon: Icon(Icons.local_police_rounded,
                          color: Colors.deepPurple),
                      title: "Communes",
                      value: communeText),
                  localisationVue(
                      icon: Icon(Icons.location_on_rounded,
                          color: prospect?.longitude != null
                              ? Colors.blue
                              : Colors.red),
                      title: "Position",
                      value: prospect?.longitude != null
                          ? "Capturé"
                          : "Non Capturé"),
                ])
            // Text("Longitude : ${recup?.longitude.toString()}"),
            // Text("Latitude : ${recup?.latitude.toString()}"),
            // Text("Agent Id : ${stockage.read('user')['id']}"),
            /*  Text("Province : ${provinceselectionner}"),
                    Text("Ville : ${villeSelect}"),
                    Text("Zone : ${zoneSelect}"),
                    Text("Commune : ${communeSelect}"),
                    Text("Nom de l'entreprise : ${company_name.text}"),
                    Text("Adresse de l'entreprise : ${company_adress.text}"),
                    Text("Contact de l'entreprise : ${company_phone.text}"),
                    Text("Type d'entrprise : ${typeSelect}"),*/
            // Text("Offres : ${selectedData}")
          ],
        ),
      ),
    );
  }

  afficheLigne({
    required String title,
    required String value,
    IconData icon = Icons.arrow_forward_ios_rounded,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(title),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                value == 'null' ? "non Rempli" : value,
                style: TextStyle(
                    fontWeight:
                        value == 'null' ? FontWeight.normal : FontWeight.bold,
                    color: value == 'null'
                        ? Colors.grey.withOpacity(.5)
                        : Colors.black),
              ),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  localisationVue({
    required String title,
    required String value,
    required Icon icon,
  }) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(title),
              SizedBox(
                height: 5,
              ),
              icon,
              SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
