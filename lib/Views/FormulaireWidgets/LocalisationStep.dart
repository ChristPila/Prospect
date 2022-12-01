import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as g;
import 'package:provider/provider.dart';

import '../../Controllers/FormulaireProspectController.dart';
import '../../Models/CommuneModel.dart';
import '../../Models/ProvinceModel.dart';
import '../../Models/VilleModel.dart';
import '../../Models/ZoneModel.dart';
import '../../Models/prosModel.dart';

class LocalisationStep extends StatefulWidget {
  final ProsModel? recup;

  final Function(String key, dynamic newValue) onChanged;

  const LocalisationStep({this.recup, required this.onChanged});

  @override
  State<LocalisationStep> createState() => _LocalisationStepState();
}

class _LocalisationStepState extends State<LocalisationStep> {
  List<ProvinceModel> provinces = [];
  List<VilleModel> villes = [];
  List<ZoneModel> zones = [];
  List<CommuneModel> communes = [];

  int? provinceselectionner;
  int? villeSelect;
  int? zoneSelect;
  int? communeSelect;

  g.Position? _position;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: _position != null ? Colors.green : Colors.orange,
        )
      ],
    );
  }

  void demanderLaLocalisation() async {
    g.Position position = await _determinePosition();
    _position = position;
    widget.onChanged("longitude", position.longitude.toString());
    widget.onChanged("latitude", position.latitude.toString());
    setState(() {});
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
    var formCtrl = context.watch<FormulaireProspectController>();
    var provinces = formCtrl.provinces;
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
                value: prov.id,
              );
            }).toList(),
            onChanged: (int? newValue) async {
              provinceselectionner = newValue!;
              villes = context
                  .read<FormulaireProspectController>()
                  .villes
                  .where((v) => v.provinceId == newValue)
                  .toList();
              widget.onChanged("province_id", newValue);
              setState(() {});
            },
          ))),
    ];
  }

  villeVue() {
    var formCtrl = context.read<FormulaireProspectController>();
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
              return DropdownMenuItem(child: Text(city.name), value: city.id);
            }).toList(),
            onChanged: (int? newValue) async {
              villeSelect = newValue!;
              zones =
                  formCtrl.zones.where((z) => z.villeId == newValue).toList();
              widget.onChanged("ville_id", newValue);
              setState(() {});
            },
          ))),
    ];
  }

  zoneVue() {
    var formCtrl = context.read<FormulaireProspectController>();
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
              return DropdownMenuItem(child: Text(z.name), value: z.id);
            }).toList(),
            onChanged: (int? newValue) async {
              zoneSelect = newValue!;
              communes =
                  formCtrl.communes.where((c) => c.zoneId == newValue).toList();
              setState(() {});
              widget.onChanged("zone_id", newValue);
              setState(() {});
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
              child: DropdownButton<int>(
            isExpanded: true,
            value: communeSelect,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: communes.map((com) {
              return DropdownMenuItem(child: Text(com.name), value: com.id);
            }).toList(),
            onChanged: (int? newValue) {
              widget.onChanged("commune_id", newValue);
              communeSelect = newValue!;

              setState(() {});
            },
          ))),
    ];
  }
}
