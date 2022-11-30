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
import 'FormulaireWidgets/IdentificationStep.dart';
import 'FormulaireWidgets/LocalisationStep.dart';
import 'FormulaireWidgets/ResumeStep.dart';

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

  get floatingActionButton => null;

  get builder => null;
  int currentStep = 0;
  bool isCompleted = false;
  int? step;

  String lastButtonText = "Confirmer";

  // TextEditingController _position = TextEditingController();

  Map<String, dynamic> formulaireValue = {
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

  int timestamp = DateTime.now().millisecondsSinceEpoch;
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
    /* nom = "Editer Prospect";
    company_name.text = widget.recup!.companyName!;
    company_adress.text = widget.recup!.companyAddress!;
    // company_type.text = widget.recup!.typeActivitiesId!.toString();
    company_phone.text = widget.recup!.companyPhone!.toString();*/
  }

  List<Step> stepList() => [
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
                  affichageSnack(context,
                      msg: "Cette clé '$key' n'est pas reconnu ");
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
            content: IdentificationStep(
              onChanged: (String key, newValue) {
                var authorizedKeys = [
                  "company_name",
                  "company_address",
                  "company_phone",
                  "type_activities_id",
                  "offer_id"
                ];
                if (!authorizedKeys.contains(key)) {
                  affichageSnack(context,
                      msg: "Cette clé '$key' n'est pas reconnu ");
                  return;
                }
                formulaireValue[key] = newValue;
              },
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
            content: ResumeStep(
              prospect: recup,
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
    return vuePrincipale();
  }

  Widget buildCompleted() {
    return Container(child: Column());
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

  vuePrincipale() {
    print("REBUILD Formulaire");

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
                        final isOneBeforeLastStep =
                            currentStep == stepList().length - 2;
                        print(isLastStep);
                        if (isOneBeforeLastStep) {
                          buildProspectModelData();
                        }
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
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.grey.withOpacity(.2),
                                      elevation: 0),
                                  child: Text(
                                    "PRECEDENT",
                                    style: TextStyle(
                                        color: currentStep != 0
                                            ? Colors.black
                                            : Colors.grey.withOpacity(.1)),
                                  ),
                                  onPressed: () {
                                    if (currentStep != 0)
                                      details.onStepCancel!();
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                      isLastStep ? lastButtonText : "SUIVANT"),
                                  onPressed: details.onStepContinue,
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
      /* zoneId: zoneSelect != null ? int.parse(zoneSelect!) : null,
      villeId: villeSelect != null ? int.parse(villeSelect!) : null,
      provinceId: provinceselectionner != null
          ? int.parse(provinceselectionner!)
          : null,
      companyName: company_name.text.toString(),
      companyAddress: company_adress.text.toString(),
      typeActivitiesId: typeSelect != null ? int.parse(typeSelect!) : null,
      companyPhone: company_phone.text.toString(),*/
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
        /*  zoneId: zoneSelect != null ? int.parse(zoneSelect!) : null,
        villeId: villeSelect != null ? int.parse(villeSelect!) : null,
        provinceId: provinceselectionner != null
            ? int.parse(provinceselectionner!)
            : null,
        companyName: company_name.text.toString(),
        companyAddress: company_adress.text.toString(),
        typeActivitiesId: typeSelect != null ? int.parse(typeSelect!) : null,
        companyPhone: company_phone.text.toString(),*/
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

  void buildProspectModelData() {
    recup = ProsModel.fromJson(formulaireValue);
    recup!.agentId = stockage.read('user')['id'];

    print("recuperation ${recup?.toJson()}");

    setState(() {});
  }
}
