import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prospect/Controllers/ActiviteController.dart';
import 'package:prospect/Controllers/CommuneController.dart';
import 'package:prospect/Controllers/OffresController.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import 'package:prospect/Controllers/ProvinceController.dart';
import 'package:prospect/Controllers/VilleController.dart';
import 'package:prospect/Controllers/ZoneController.dart';
import 'package:prospect/models/ActiviteModel.dart';
import 'package:prospect/models/CommuneModel.dart';
import 'package:prospect/models/OffresModel.dart';
import 'package:prospect/models/ProspectModel.dart';
import 'package:prospect/models/ProvinceModel.dart';
import 'package:prospect/models/VilleModel.dart';
import 'package:prospect/models/ZoneModel.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:file_picker/file_picker.dart';

class Prospect extends StatefulWidget {
  const Prospect({Key? key}) : super(key: key);

  @override
  State<Prospect> createState() => _ProspectState();
}

class _ProspectState extends State<Prospect> {
  //TextEditingController company_name = TextEditingController();

  Position? _position;
  Uint8List? exportedImage;
  bool isLoad = false;

  SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.red,
    exportBackgroundColor: Colors.yellowAccent,
  );
  List<ProvinceModel>? provinces;
  List<ActiviteModel>? activites;
  List<VilleModel>? villes;
  List<ZoneModel>? zones;
  List<CommuneModel>? communes;
  List<OffresModel> offres = [];
  int prov = 2;
  List selectedData = [];
  static String? provinceselectionner;
  String? villeSelect;
  String? zoneSelect;
  String? communeSelect;
  String offreSelect = "voice call";
  String? typeSelect;
  get floatingActionButton => null;
  get builder => null;
  int currentStep = 0;
  bool isCompleted = false;
  int? step;
  TextEditingController company_name = TextEditingController();
  TextEditingController company_adress = TextEditingController();
  TextEditingController company_type = TextEditingController();
  TextEditingController company_phone = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<Step> stepList() => [
        Step(
            state:
                currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(
              "LOCALISATION",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height - 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    localisation(),
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
            )),
        Step(
            state:
            currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text(
              "IDENTIFICATION",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
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
                    ...typeVue(),
                    SizedBox(
                      height: 8,
                    ),
                    offreVue(),
                    SizedBox(
                      height: 8,
                    ),
                    visualiseroffre(),
                  ],
                ),
              ),
            )),
        Step(
              state:StepState.complete,
              isActive: currentStep >= 2,
              title: const Text("RESUMÉ",
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
                    Text("Province : ${provinceselectionner}",),
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
        /*Step(
            state: StepState.editing,
            isActive: _activeStepIndex == 2,
            title: const Text(
              "Etape3",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height - 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: ListTile(
                        title: Text(
                          "Images",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    imgVue(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: ListTile(
                        title: Text(
                          "Documents",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    documentVue(),
                    Container(
                      height: 40,
                      child: ListTile(
                        title: Text(
                          "Signature",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //signatureVue(),
                    Container(
                      width: double.infinity,
                      child: Signature(
                        controller: controller,
                        width: double.infinity,
                        height: 150,
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //paddingsi(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    if (exportedImage != null)
                      Container(
                          width: 300,
                          height: 150,
                          child: Image.memory(exportedImage!)),
                    Container(
                      height: 8,
                    ),
                    Container(
                      child: (Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [],
                      )),
                    )
                  ],
                ),
              ),
            )),*/
      ];


  //Liste des images
  List<XFile>? imageFileList = [];
  XFile? imageFile1;
  PlatformFile? file;
  PlatformFile? file1;

  //Liste des documents
  List<File> lisDoc = [];

  //here filepicker
  void openFiles() async {
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
  }

  @override
  Widget build(BuildContext context) {
    print(offres.map((e) => e.value).toList());
    print(selectedData.map((e) => e).toList());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white10,
            title: Text(
              "Nouveau Prospect",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25,
              ),
            )),
        body: isCompleted ? buildCompleted()
            : Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.orange),
          ),
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            steps: stepList(),
            onStepContinue: () async {
              final isLastStep =  currentStep == stepList().length - 1;
              print(isLastStep);
              if (isLastStep) {
                setState(()=> isCompleted = true);
                  Chargement(context);
                  var data = ProspectModel(
                      longitude: _position?.longitude.toString(),
                      latitude: _position?.latitude.toString(),
                      agentId: "1",
                      communeId: "1",
                      zoneId: "1",
                      villeId: "1",
                      provinceId: "1",
                      companyName: company_name.text,
                      companyAddress: company_adress.text,
                      companyTypeId: "1",
                      companyPhone: company_phone.text,
                      offerId: "1, 2",
                      state: "1",
                      remoteId: "12RT567",
                  );
                  var response = await context.read<ProspectController>().submitProspect(data).catchError((err){});
                  Navigator.pop(context);
                  if(response.statusCode == 200 || response.statusCode == 201){
                    succesPopUp(context);
                    return response.body;
                  }
                  debugPrint("Succès");
              } else {
                setState(() => currentStep +=1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep = step),
            onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep -=1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == stepList().length - 1;
              return Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text(isLastStep ? "CONFIRMER" : "SUIVANT"),
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
            }
          ),
        ),
      ),
    );
  }

  Widget buildCompleted() {
    return Container(
      child: Column(

      )
    );
  }

  void _getCurrentPosition() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permission are denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  localisation(){
    return Column(
      children: [
        _position != null ? Text(_position.toString()) : Text("Cliquer sur l'icone pour recevoir la localisation"),
        IconButton(
            onPressed: _getCurrentPosition,
            icon: Icon(Icons.location_on_outlined), color: Colors.orange,)
      ],
    );
  }

  provinceVue() {
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
                      fontSize: 20)
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            isExpanded: true,
            value: provinceselectionner,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: provinces?.map((prov) {
              return DropdownMenuItem(
                child: Text(prov.name),
                value: prov.id.toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() async {
                provinceselectionner = newValue!;
                villes = await RemoteServicesVilles.getVilles(int.parse(provinceselectionner!));
                if(villes!=null){
                  setState(() {
                    isLoad=true;
                  });
                }
              });
            },
          )
          )
      ),
    ];
  }

  typeVue() {
    return [
      SizedBox(
        height: 20,
      ),
      InputDecorator(
          decoration: InputDecoration(
              label: Text(
                "Type d'activité",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20)
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: typeSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: activites?.map((activity) {
                  return DropdownMenuItem(
                    value: activity.name,
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

  getData() async {
    provinces = await RemoteServicesProv.getProvinces();
    offres = await RemoteServicesOf.getOffres();
    activites = await RemoteServicesAct.getActivity();
    if(provinces!=null || offres!= null || activites!= null)
    {
      setState(() {
        isLoad=true;
      });
    }
  }

  villeVue() {
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
                      fontSize: 20)
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: villeSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: villes?.map((city) {
                  return DropdownMenuItem(
                    child: Text(city.name),
                    value: city.id.toString()
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() async {
                    villeSelect = newValue!;
                    zones = await RemoteServicesZone.getZone(int.parse(villeSelect!));
                    if(zones!=null){
                      setState(() {
                        isLoad=true;
                      });
                    }
                  });
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
                      fontSize: 20)
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: zoneSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: zones?.map((z) {
                  return DropdownMenuItem(
                      child: Text(z.name),
                      value: z.id.toString()
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() async {
                    zoneSelect = newValue!;
                    communes = await RemoteServicesCommune.getCommune(int.parse(zoneSelect!));
                    if(communes!=null){
                      setState(() {
                        isLoad=true;
                      });
                    }
                  });
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
                      fontSize: 20)
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 10)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: communeSelect,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: communes?.map((com) {
                  return DropdownMenuItem(
                      child: Text(com.name),
                      value: com.id.toString()
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    communeSelect = newValue!;
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
        child: TextField(
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
              )),
        ),
      ),
    ];
  }

  offreVue() {
    return Container(
      width: 500,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: Colors.grey, width: 2),
          primary: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.all(18),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: StatefulBuilder(builder: (context, setState2) {
                return AlertDialog(
                    title: Text("Choisir les offres"),
                    contentPadding: const EdgeInsets.all(20.0),
                    content: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: offres?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  OffresModel offre = offres![index];
                                  return Container(
                                    child: CheckboxListTile(
                                        title: Text(offre.name),
                                        //controlAffinity: ListTileControlAffinity.leading,
                                        value: offre.value,
                                        activeColor: Colors.orange,
                                        onChanged: (bool? newValue) {
                                          if(selectedData.indexOf(offre.name)<0){
                                            setState2(() {
                                              offre.value=newValue!;
                                              selectedData.add(offre.name);
                                            });
                                            setState(() {

                                            });
                                          }else{
                                            setState2(() {
                                              offre.value=newValue!;
                                              selectedData.removeWhere((element) => element == offre.name);
                                            });
                                            setState(() {
                                              
                                            });
                                          }
                                        },
                                      secondary: Icon(Icons.local_offer_outlined),
                                        ),
                                  );
                                }),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "FERMER",
                            ),
                          )
                        ],
                      ),
                    ));
              }),
            ),
          );
        },
        child: Text(
          "Selectionner Offre",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }

  imgVue() {
    return Container(
      height: 100,
      //color: Colors.red,
      child: Row(
        //scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.grey, width: 2),
              primary: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.all(35),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: imageFileList?.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Container(
                        width: 140,
                        height: 200,
                        child: Image.file(File(imageFileList![index].path),
                            fit: BoxFit.cover)),
                  );
                }),
          ),
        ],
      ),
    );
  }

  documentVue() {
    return Container(
      height: 100,
      child: Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.grey, width: 2),
                  primary: Colors.transparent,
                  elevation: 0,
                  padding: EdgeInsets.all(35)),
              onPressed: () {
                openFiles();
              },
              child: Icon(
                Icons.file_download,
                color: Colors.blue,
              )),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: lisDoc.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var fil = lisDoc[index];
                  print(fil.path);
                  var completePath = fil.path;
                  var fileName = (completePath.split('/').last);
                  var fileExtension = (fileName.split(".").last);
                  print(completePath);
                  print(fileName);
                  print(fileExtension);

                  return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Container(
                        color: Colors.black12,
                        width: 140,
                        height: 200,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fileExtension,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              fileName,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue),
                            ),
                          ],
                        )),
                        // child: Text(lisDoc[index].name),
                      ));
                }),
          ),
        ],
      ),
    );
  }

  signatureVue() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          SizedBox(
            width: 15,
          ),
          sign(),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget imageProfile() {
    return imageFileList == null
        ? Container(
            width: 140,
            height: 180,
            color: Colors.black12,
          )
        : Container(
            width: 140,
            height: 180,
            color: Colors.black12,
          );
  }

  Widget imageProfile2() {
    return Stack(
      children: <Widget>[
        imageFile1 == null
            ? Container(
                width: 140,
                height: 180,
                color: Colors.black12,
              )
            : Container(
                width: 140,
                height: 180,
              ),
        //AssetImage(""),
        Positioned(
          bottom: 20.0,
          right: 35.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget imageProfile3() {
    return Stack(
      children: <Widget>[
        Container(
          width: 140,
          height: 180,
          color: Colors.black12,
        ),
        //AssetImage(""),
        Positioned(
          bottom: 20.0,
          right: 35.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget document1() {
    return Container(
      //child: ElevatedButton(onPressed: () {openFiles();}, child: Icon(Icons.file_download)),
      //child: Icon(Icons.file_download),

      width: 140,
      height: 180,
      color: Colors.black26,
    );
  }

  Widget document2() {
    return Stack(
      children: <Widget>[
        Container(
          width: 140,
          height: 180,
          color: Colors.black26,
        ),
        //AssetImage(""),
        Positioned(
          bottom: 20.0,
          right: 35.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget document3() {
    return Stack(
      children: <Widget>[
        Container(
          width: 140,
          height: 180,
          color: Colors.black26,
        ),
        //AssetImage(""),
        Positioned(
          bottom: 20.0,
          right: 35.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget sign() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: ((builder) => bottomSheet()),
        );
      },
      child: Container(
        width: 280,
        height: 180,
        color: Colors.black12,
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choisir la photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  _getFromCamera();
                },
                child: Icon(Icons.camera),
              ),
              Text("camera"),
              TextButton(
                onPressed: () {
                  _getFromGallery();
                },
                child: Icon(Icons.image),
              ),
              Text("gallery")
            ],
          )
        ],
      ),
    );
  }

  _getFromGallery() async {
    List<XFile>? pickedFile = await ImagePicker()
        .pickMultiImage(maxWidth: 1800, maxHeight: 1800, imageQuality: 12);
    if (pickedFile!.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(pickedFile);
      });
    }
    Navigator.pop(context);
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFileList = pickedFile.path as List<XFile>?;
      });
    }
    Navigator.pop(context);
  }

  labelText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  paddingsi() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: () async {
              exportedImage = await controller.toPngBytes();
              setState(() {});
            },
            child: const Text(
              "save",
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)))),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              controller.clear();
            },
            child: const Text(
              "clear",
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)))),
          ),
        ),
      ],
    );
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

  Chargement(BuildContext context, [int duree = 1500]) async {
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

  succesPopUp(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
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
                    fontWeight: FontWeight.bold, color: Colors.green
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: new Text("OK")
              )
            ],
          );
        }
    );
  }


// User canceled the picker

}
