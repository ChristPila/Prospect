import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as g;

import '../../Controllers/FormulaireProspectController.dart';
import '../../Models/CommuneModel.dart';
import '../../Models/ProvinceModel.dart';
import '../../Models/VilleModel.dart';
import '../../Models/ZoneModel.dart';
import '../../Models/prosModel.dart';

class LocalisationStep extends StatefulWidget {
  final ProsModel? recup ;

   const LocalisationStep({this.recup}) ;

  @override
  State<LocalisationStep> createState() => _LocalisationStepState();
}

class _LocalisationStepState extends State<LocalisationStep> {
  List<ProvinceModel> provinces = [];
  List<VilleModel> villes = [];
  List<ZoneModel> zones = [];
  List<CommuneModel> communes = [];

  String? villeSelect;
  String? zoneSelect;
  String? communeSelect;
  String? provinceselectionner;

  g.Position? _position;



  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height - 250,
      child: SingleChildScrollView(
        child: Column(
          children: [
            localisationVue(),
            ...provinceVue(),
            SizedBox(
              height: 8,
            ),
            ...villeVue(),
            SizedBox(
              height: 8,
            ),
            ...zoneVue(),
            SizedBox(
              height: 8,
            ),
            ...communeVue(),
          ],
        ),
      ),
    );
  }

  localisationVue() {
    return Column(
      children: [
        _position != null
            ? Text("Prospect localisé")
            : Text("Cliquer sur l'icone pour recevoir la localisation"),
     IconButton(
          onPressed: demanderLaLocalisation,
          icon: Icon(Icons.location_on_outlined),
          color: _position != null? Colors.green: Colors.orange,
        )

      ],
    );
  }

  void demanderLaLocalisation() async {
    g.Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }


  Future<g.Position> _determinePosition() async {
    g.LocationPermission permission;

    permission = await g.Geolocator.checkPermission();

    if (permission == g.LocationPermission.denied) {
      permission = await g.Geolocator.requestPermission();
      if (permission == g.LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }
    return await g.Geolocator.getCurrentPosition();
  }


  provinceVue() {
    // var formCtrl = context.watch<FormulaireProspectController>();
    // var provinces = formCtrl.provinces;
    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text("Province",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: provinceselectionner,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: provinces.map((prov) {
                  return DropdownMenuItem(
                    child: Text(prov.name),
                    value: prov.id.toString(),
                  );
                }).toList(),
                onChanged: (String? newValue) async {
                  provinceselectionner = newValue!;
                  var province_id = int.parse(provinceselectionner!);
                  villes = context
                      .read<FormulaireProspectController>()
                      .villes
                      .where((v) => v.provinceId == province_id)
                      .toList();
                  //   await RemoteServicesVilles.getVilles(
                  //int.parse(provinceselectionner!));
                  setState(() {});
                },
              ))),
    ];
  }

  villeVue() {
    var formCtrl = context.read<FormulaireProspectController>();
    var villesLocales = formCtrl.villes;
    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text("Ville",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: villeSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: villes.map((city) {
                  return DropdownMenuItem(
                      child: Text(city.name), value: city.id.toString());
                }).toList(),
                onChanged: (String? newValue) async {
                  villeSelect = newValue!;
                  var ville_id = int.parse(villeSelect!);
                  zones = context
                      .read<FormulaireProspectController>()
                      .zones
                      .where((z) => z.villeId == ville_id)
                      .toList();
                  if (zones != null) {
                    setState(() {});
                  }
                },
              ))),
    ];
  }

  zoneVue() {
    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text("Zone",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: zoneSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: zones.map((z) {
                  return DropdownMenuItem(
                      child: Text(z.name), value: z.id.toString());
                }).toList(),
                onChanged: (String? newValue) async {
                  zoneSelect = newValue!;
                  var zone_id = int.parse(zoneSelect!);
                  communes = context
                      .read<FormulaireProspectController>()
                      .communes
                      .where((c) => c.zoneId == zone_id)
                      .toList();

                },
              ))),
    ];
  }

  communeVue() {
    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text("Commune",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: communeSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: communes.map((com) {
                  return DropdownMenuItem(
                      child: Text(com.name), value: com.id.toString());
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    communeSelect = newValue!;
                  });
                },
              ))),
    ];
  }
}
