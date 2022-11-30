import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/FormulaireProspectController.dart';
import '../../Models/prosModel.dart';

class IdentificationStep extends StatefulWidget {
  final ProsModel? recup;
  final Function(String key, dynamic newValue) onChanged;

  const IdentificationStep({this.recup, required this.onChanged});

  @override
  State<IdentificationStep> createState() => _IdentificationStepState();
}

class _IdentificationStepState extends State<IdentificationStep> {
  TextEditingController company_name = TextEditingController();
  TextEditingController company_adress = TextEditingController();
  TextEditingController company_type = TextEditingController();
  TextEditingController company_phone = TextEditingController();

  int? offreSelect;
  int? typeSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...nomprospectVue(),
            SizedBox(
              height: 15,
            ),
            ...adresseVue(),
            SizedBox(
              height: 15,
            ),
            ...contactVue(),
            SizedBox(
              height: 8,
            ),
            ...typeVue(context),
            SizedBox(
              height: 8,
            ),
            ...offreVue(context),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  nomprospectVue() {
    return [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          controller: company_name,
          onChanged: (String newV) {
            widget.onChanged("company_name", newV);
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'nom entreprise',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Text(
                "Nom Entreprise",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              )),
        ),
      ),
    ];
  }

  adresseVue() {
    return [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          controller: company_adress,
          onChanged: (String newV) {
            widget.onChanged("company_address", newV);
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'adresse',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Text(
                "Adresse Entreprise",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              )),
        ),
      ),
    ];
  }

  contactVue() {
    return [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          onChanged: (String newV) {
            widget.onChanged("company_phone", newV);
          },
          controller: company_phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Numero de telephone',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(
              "Contact Entreprise",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                    .hasMatch(value)) {
              return "Entrez un nom valide";
            } else {
              return null;
            }
          },
        ),
      ),
    ];
  }



  typeVue(BuildContext context) {
    var formCtrl = context.watch<FormulaireProspectController>();
    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text("Type d'activité",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            isExpanded: true,
            value: typeSelect,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items:formCtrl.activities.map((activity) {
              return DropdownMenuItem(
                value: activity.id,
                child: Text(activity.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              typeSelect = newValue!;
              widget.onChanged("type_activities_id", newValue);

              setState(() {});
            },
          ))),
    ];
  }

  offreVue(BuildContext context) {
    var formCtrl = context.watch<FormulaireProspectController>();

    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text("Offres",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: offreSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: formCtrl.offres.map((offer) {
                  return DropdownMenuItem(
                    value: offer.id,
                    child: Text(offer.name.toString()),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  offreSelect = newValue!;
                  widget.onChanged("offer_id", newValue);

                  setState(() {});
                },
              ))),
    ];
  }
}
