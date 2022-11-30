import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as g;
import 'package:get_storage/get_storage.dart';
import 'package:prospect/Models/ActiviteModel.dart';
import 'package:prospect/Models/OffresModel.dart';
import 'package:prospect/Tools/Parametres.dart';
import 'package:provider/provider.dart';

import '../Controllers/FormulaireProspectController.dart';
import '../Models/prosModel.dart';
import 'FormulaireWidgets/LocalisationStep.dart';

//import 'package:signature/signature.dart';
//import 'package:file_picker/file_picker.dart';

class FormulaireProspectPage extends StatefulWidget {
  final ProsModel? recup;

  const FormulaireProspectPage({super.key, this.recup});

  @override
  State<FormulaireProspectPage> createState() => _FormulaireProspectPageState();
}

class _FormulaireProspectPageState extends State<FormulaireProspectPage> {
  GetStorage stockage = GetStorage(Parametres.STOCKAGE_VERSION);
  ProsModel? recup = ProsModel();
  g.Position? _position;
  Uint8List? exportedImage;
  bool isLoad = false;

  /*SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.red,
    exportBackgroundColor: Colors.yellowAccent,
  );*/

  List<ActiviteModel> activites = [];

  List<OffresModel> offres = [];
  List selectedData = [];
  String? provinceselectionner;
  String? villeSelect;
  String? zoneSelect;
  int? communeSelect;
  String? offreSelect;
  String? typeSelect;

  get floatingActionButton => null;

  get builder => null;
  int currentStep = 0;
  bool isCompleted = false;
  int? step;

  // TextEditingController _position = TextEditingController();
  TextEditingController company_name = TextEditingController();
  TextEditingController company_adress = TextEditingController();
  TextEditingController company_type = TextEditingController();
  TextEditingController company_phone = TextEditingController();

  Map formulaireValue = {
    "longitude": null,
    "latitude": null,
    "agent_id": null,
    "commune_id": null,
    "zone_id": null,
    "ville_id": null,
    "province_id": null,
    "company_name": null,
    "company_address": null,
    "type_activities_id": null,
    "company_phone": null,
    "offer_id": null,
    "state": null,
    "pieces_jointes_id": null,
    "remote_id": null,
  };

  int timestamp = DateTime
      .now()
      .millisecondsSinceEpoch;
  var nom = "Nouveau Prospect";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //recup = widget.recup;

    if (widget.recup != null) {
      editionFormulaire();
    }
    //getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //recuperationDataForm();
    });
  }

  editionFormulaire() {
    nom = "Editer Prospect";
    company_name.text = widget.recup!.companyName!;
    company_adress.text = widget.recup!.companyAddress!;
    // company_type.text = widget.recup!.typeActivitiesId!.toString();
    company_phone.text = widget.recup!.companyPhone!.toString();
  }

  List<Step> stepList() =>
      [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(
              "LOCALISATION",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: LocalisationStep(
              onChanged: (String key, dynamic newValue) {
                var authorizedKeys = [
                  "longitude",
                  "latitude",
                  "agent_id",
                  "commune_id",
                  "zone_id",
                  "ville_id",
                  "province_id",
                ];
                if (!authorizedKeys.contains(key)) {
                  affichageSnack(
                      context, msg: "Cette clé '$key' n'est pas reconnu ");
                  return;
                }
                formulaireValue[key] = newValue;
              },
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text(
              "IDENTIFICATION",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 250,
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
                    visualiseroffre(),
                  ],
                ),
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: currentStep >= 2,
            title: const Text(
              "RESUMÉ",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Longitude : ${_position?.longitude.toString()}"),
                  Text("Latitude : ${_position?.latitude.toString()}"),
                  Text("Agent Id : ${stockage.read('user')['id']}"),
                  Text("Province : ${provinceselectionner}"),
                  Text("Ville : ${villeSelect}"),
                  Text("Zone : ${zoneSelect}"),
                  Text("Commune : ${communeSelect}"),
                  Text("Nom de l'entreprise : ${company_name.text}"),
                  Text("Adresse de l'entreprise : ${company_adress.text}"),
                  Text("Contact de l'entreprise : ${company_phone.text}"),
                  Text("Type d'entrprise : ${typeSelect}"),
                  Text("Offres : ${selectedData}")
                ],
              ),
            ))
      ];

  //Liste des images
  /*List<XFile>? imageFileList = [];
  XFile? imageFile1;
  PlatformFile? file;
  PlatformFile? file1;

  //Liste des documents
  List<File> lisDoc = [];*/

  //here filepicker
  /*void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (resultFile != null) {
      //lisDoc.add(resultFile.files.first);
      List<File> files = resultFile.paths.map((path) => File(path!)).toList();
      lisDoc.addAll(files);
      setState(() {});
    } else {}
  }*/

  @override
  Widget build(BuildContext context) {
    var userData = stockage.read('user');
    var currentId = userData['id'];
    print(selectedData.map((e) => e).toList());
    print("AGENT ID : $currentId");
    return nouveauProspect();
  }

  Widget buildCompleted() {
    return Container(child: Column());
  }

  typeVue(BuildContext context) {
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
                items: activites.map((activity) {
                  return DropdownMenuItem(
                    value: activity.id.toString(),
                    child: Text(activity.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    typeSelect = newValue!;
                  });
                },
              ))),
    ];
  }

  nomprospectVue() {
    return [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextField(
          controller: company_name,
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
        child: TextField(
          controller: company_adress,
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
          controller: company_phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'contact',
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

  offreVue(BuildContext context) {
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
                items: offres.map((offer) {
                  return DropdownMenuItem(
                    value: offer.id.toString(),
                    child: Text(offer.name.toString()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    offreSelect = newValue!;
                  });
                },
              ))),
    ];
  }

  visualiseroffre() {
    return Wrap(
        children: selectedData.map((e) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Text(
              e,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList());
  }

  Chargement(BuildContext context, [int duree = 150]) async {
    ouvrirDialog(context);
  }

  ouvrirDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Chargement en cours..."),
        );
      },
    );
  }

  succesPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("ENVOI DU PROSPECT")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Prospects envoyés",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("OK"))
            ],
          );
        });
  }

  nouveauProspect() {
    bouton() {
      if (nom == "Editer Prospect") {
        return "VALIDER";
      } else {
        return "CONFIRMER";
      }
    }

    return WillPopScope(
      onWillPop: () async {
        await validerFormulaire(true);
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  if (currentStep > 0) {
                    currentStep--;
                    setState(() {});
                    return;
                  }
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white10,
              title: Text(
                nom,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                ),
              )),
          body: isCompleted
              ? buildCompleted()
              : Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Colors.orange),
            ),
            child: Stepper(
                type: StepperType.horizontal,
                currentStep: currentStep,
                steps: stepList(),
                onStepContinue: () async {
                  final isLastStep = currentStep == stepList().length - 1;
                  print(isLastStep);
                  if (isLastStep) {
                    setState(() => isCompleted = true);
                    Chargement(context);
                    validerFormulaire();
                    succesPopUp(context);
                    debugPrint("Succès");
                  } else {
                    setState(() => currentStep += 1);
                  }
                },
                onStepTapped: (step) =>
                    setState(() => currentStep = step),
                onStepCancel: currentStep == 0
                    ? null
                    : () => setState(() => currentStep -= 1),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final isLastStep = currentStep == stepList().length - 1;
                  return Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child:
                            Text(isLastStep ? bouton() : "SUIVANT"),
                            onPressed: details.onStepContinue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (currentStep != 0)
                          Expanded(
                            child: ElevatedButton(
                              child: Text("PRECEDENT"),
                              onPressed: details.onStepCancel,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  validerFormulaire([bool save = false]) async {
    var userData = stockage.read('user');
    var currentId = userData['id'];
    var data = ProsModel(
      longitude: _position?.longitude.toString(),
      latitude: _position?.latitude.toString(),
      agentId: currentId,
      //communeId: communeSelect != null ? int.parse(communeSelect!) : null,
      zoneId: zoneSelect != null ? int.parse(zoneSelect!) : null,
      villeId: villeSelect != null ? int.parse(villeSelect!) : null,
      provinceId: provinceselectionner != null
          ? int.parse(provinceselectionner!)
          : null,
      companyName: company_name.text.toString(),
      companyAddress: company_adress.text.toString(),
      typeActivitiesId: typeSelect != null ? int.parse(typeSelect!) : null,
      companyPhone: company_phone.text.toString(),
      offerId: 1,
      state: "1",
      remoteId: timestamp.toString(),
    );
    debugPrint('DONNEE: ${data.toJson()}');
    print(save);
    if (save) {
      var brou = ProsModel(
        longitude: _position?.longitude.toString(),
        latitude: _position?.latitude.toString(),
        agentId: currentId,
        //communeId: communeSelect != null ? int.parse(communeSelect!) : null,
        zoneId: zoneSelect != null ? int.parse(zoneSelect!) : null,
        villeId: villeSelect != null ? int.parse(villeSelect!) : null,
        provinceId: provinceselectionner != null
            ? int.parse(provinceselectionner!)
            : null,
        companyName: company_name.text.toString(),
        companyAddress: company_adress.text.toString(),
        typeActivitiesId: typeSelect != null ? int.parse(typeSelect!) : null,
        companyPhone: company_phone.text.toString(),
        offerId: 1,
        state: "4",
        remoteId: timestamp.toString(),
      );
      print("DATA BROUILLON ${brou.toJson()}");
      brouillon(brou);
    } else {
      var response = await context
          .read<FormulaireProspectController>()
          .submitProspect(data)
          .catchError((err) {});
      Navigator.pop(context);
    }
  }

  brouillon(ProsModel brou) {
    Map a = FormulaireProspectController()
        .lecturestockageLocale(Parametres.keyProspect);
    a[timestamp.toString()] = brou.toJson();
    FormulaireProspectController()
        .ecritureStockageLocale(Parametres.keyProspect, a);
  }

// User canceled the picker
  affichageSnack(BuildContext context,
      {required String msg,
        double duree = 3,
        Color bgColor = Colors.white,
        Color textColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
            SizedBox(
              width: 20,
            ),
            Text(msg, style: TextStyle(color: textColor)),
          ],
        ),
        duration: Duration(seconds: 5),
        backgroundColor: bgColor,
      ),
    );
  }
}
