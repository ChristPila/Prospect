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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  succesPopUp(BuildContext context) async {
    await showDialog(
        barrierDismissible: false,
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
    print("REBUILD Formulaire $currentStep");

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
          body: /*isCompleted
              ? buildCompleted()
              : */
              Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Colors.orange),
            ),
            child: Form(
              key: formKey,
              child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  steps: stepList(),
                  onStepContinue: () async {
                    final isLastStep = currentStep == stepList().length - 1;
                    final isOneBeforeLastStep =
                        currentStep == stepList().length - 2;
                    debugPrint("isLastStep $isLastStep");

                    if (isLastStep) {
                      setState(() => isCompleted = true);
                      validerFormulaire();
                    } else {
                      if (isOneBeforeLastStep) {
                        var res = buildProspectModelData();
                        if (!res) return;
                      }
                      currentStep += 1;
                      setState(() {});
                    }
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
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
                                  backgroundColor: Colors.grey.withOpacity(.2),
                                  elevation: 0),
                              child: Text(
                                "PRECEDENT",
                                style: TextStyle(
                                    color: currentStep != 0
                                        ? Colors.black
                                        : Colors.grey.withOpacity(.1)),
                              ),
                              onPressed: () {
                                if (currentStep != 0) details.onStepCancel!();
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              child:
                                  Text(isLastStep ? lastButtonText : "SUIVANT"),
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
      ),
    );
  }

  buildProspectModelData() {
    recup = ProsModel.fromJson(formulaireValue);
    recup!.agentId = stockage.read('user')['id'];
    print("recuperation ${recup?.toJson()}");
    recup!.remoteId =
        recup!.remoteId ?? DateTime.now().millisecondsSinceEpoch.toString();
    // validation
    final form = formKey.currentState;
    if (!form!.validate()) {
      affichageSnack(context,
          msg: "Certains champs sont obligatoires", duree: 1);
      return false;
    }

    if (recup!.latitude == null || recup!.longitude == null) {
      affichageSnack(context, msg: "Localisation non capturée", duree: 1);
      return false;
    }

    if (recup!.communeId == null) {
      affichageSnack(context, msg: "Commune non selectionnée", duree: 1);
      return false;
    }
    if (recup!.typeActivitiesId == null) {
      affichageSnack(context, msg: "Type d'activité non selectionné", duree: 1);
      return false;
    }

    if (recup!.offerId == null) {
      affichageSnack(context, msg: "Offre non selectionnée", duree: 1);
      return false;
    }

    return true;
  }

  validerFormulaire([bool save = false]) async {
    var formCtrl = context.read<FormulaireProspectController>();
    ProsModel data = recup!;
    debugPrint('DONNEE: ${data.toJson()}');

    if (save) {
      formCtrl.creerCopieLocale(data);
      affichageSnack(context,
          msg: 'Brouillon sauvegardé', textColor: Colors.grey);
    }

    if (!save) {
      Chargement(context);
      try {
        int id = await formCtrl.submitProspect(data);
        Navigator.pop(context);
        data.id = id;
        data.state = "1";
        formCtrl.creerCopieLocale(data);

        debugPrint('success data ${data.toJson()}');
        affichageSnack(context,
            msg: 'Enregistrement réussie !', textColor: Colors.deepOrange);
        await Future.delayed(Duration(milliseconds: 3500));
        // await succesPopUp(context);
        debugPrint("Succès");
        //Navigator.pop(context);
      } catch (e) {
        debugPrint('failed data ${data.toJson()}');

        affichageSnack(context, msg: e.toString());
        Navigator.pop(context);
        formCtrl.creerCopieLocale(data);
        affichageSnack(context,
            msg: 'Brouillon sauvegardé', textColor: Colors.grey);
        await Future.delayed(Duration(milliseconds: 3500));
        //Navigator.pop(context);
      }
    }
  }

// User canceled the picker
  affichageSnack(BuildContext context,
      {required String msg,
      int duree = 3,
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
        duration: Duration(seconds: duree),
        backgroundColor: bgColor,
      ),
    );
  }
}
