import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../Controllers/DayToDateController.dart';
import '../Controllers/GetAllProspectsController.dart';
import '../Controllers/ProspectController.dart';
import '../Controllers/sevenLastDaysController.dart';
import '../Tools/Utilitaires.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshAllData();
    });
  }

  refreshAllData() async {
    context.read<SevenLastDaysController>().getReportData();
    context.read<DayToDateController>().getReportData();
    context.read<GetAllProspectsController>().getReportData();
    await context.read<ProspectController>().recupererDonneesAPI();
    getDataBrouillons();

  }

  getDataBrouillons() {
    GetStorage stockage = GetStorage(Utilitaires.STOCKAGE_VERSION);
    var brouillons_brut = stockage.read("PROSPECT");
    if (brouillons_brut != null) {
      var brouillonsMap = json.decode(brouillons_brut) as Map;
      List toList =
      brouillonsMap.entries.map((e) {
        return e.value ;
      }).toList();
      var brouillonsList = toList.where((e) => e['state'] == '4').toList();
      nombreBrouillons = brouillonsList.length;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: MenuLateral(),
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
                  nbreBrouillons: nombreBrouillons,),
              SevenLastDays(),
              DayToDate(),
            ],
          ),
        ),
      ),
    );
  }
}
