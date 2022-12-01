import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prospect/Tools/Parametres.dart';
import 'package:provider/provider.dart';

import '../Controllers/DayToDateController.dart';
import '../Controllers/FormulaireProspectController.dart';
import '../Controllers/GetAllProspectsController.dart';
import '../Controllers/ProspectController.dart';
import '../Controllers/sevenLastDaysController.dart';
import 'Layouts/DayToDate.dart';
import 'Layouts/MenuLateral.dart';
import 'Layouts/SevenLastDays.dart';
import 'Layouts/Statistiques.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nombreBrouillons = 0;
  var nombreVisits = 0;
  GetStorage stockage = GetStorage(Parametres.STOCKAGE_VERSION);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshAllData();
    });
  }

  recuperationDataForm() async {
    var prosFormCtrl = context.read<FormulaireProspectController>();
    prosFormCtrl.provinceRecup();

    prosFormCtrl.villeRecup();

    prosFormCtrl.zoneRecup();

    prosFormCtrl.communeRecup();

    prosFormCtrl.activityRecup();

    prosFormCtrl.offreRecup();
  }

  refreshAllData() async {
    recuperationDataForm();
    context.read<SevenLastDaysController>().getReportData();
    context.read<DayToDateController>().getReportData();
    context.read<GetAllProspectsController>().getReportData();
    // await context.read<ProspectController>().recupererDonneesAPI();
    // getDataVisit();
    getLocaleData();
  }

  getLocaleData() {
    var prosCtrl=context.read<ProspectController>();
    var userData = stockage.read('user');
    var currentId = userData['id'];
    prosCtrl.recupererDonneesLocales(currentId);
    var prospects=prosCtrl.data;
    // var cle = "${Parametres.keyProspect}_$currentId";
    nombreVisits=prospects.length;
    nombreBrouillons= prospects.where((e) => e.state == '4').length;


   /* var brouillons_brut = stockage.read(cle);
    if (brouillons_brut != null) {
      var brouillonsMap = json.decode(brouillons_brut) as Map;
      List toList = brouillonsMap.entries.map((e) {
        return e.value;
      }).toList();

      var brouillonsList = toList.where((e) => e['state'] == '4').toList();
      var brouillonsid =
          brouillonsList.where((e) => e['agent_id'] == currentId).toList();
      nombreBrouillons = brouillonsid.length;
    }*/
    setState(() {});
  }

/*  getDataVisit() {
    var visit_brut = stockage.read("getAllProspect");
    if (visit_brut != null) {
      nombreVisits = visit_brut as int;
    }
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: MenuLateral(
            onBrouillonCreated: () {
              refreshAllData();
            },
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("Tableau de bord"),
          actions: [
            IconButton(
                onPressed: () {
                  refreshAllData();
                },
                iconSize: 40,
                icon: Icon(
                  Icons.refresh,
                  size: 30,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 11),
              Statistique(
                  nbreBrouillons: nombreBrouillons, nbrevisits: nombreVisits),
              SevenLastDays(),
              DayToDate(),
            ],
          ),
        ),
      ),
    );
  }
}
