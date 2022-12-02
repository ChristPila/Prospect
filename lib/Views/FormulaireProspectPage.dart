import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as g;
import 'package:get_storage/get_storage.dart';
import 'package:prospect/Controllers/ActiviteController.dart';
import 'package:prospect/Controllers/CommuneController.dart';
import 'package:prospect/Controllers/OffresController.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import 'package:prospect/Controllers/VilleController.dart';
import 'package:prospect/Controllers/ZoneController.dart';
import 'package:prospect/Tools/Parametres.dart';
import 'package:prospect/Models/ActiviteModel.dart';
import 'package:prospect/Models/CommuneModel.dart';
import 'package:prospect/Models/OffresModel.dart';
import 'package:prospect/Models/ProvinceModel.dart';
import 'package:prospect/Models/VilleModel.dart';
import 'package:prospect/Models/ZoneModel.dart';
import 'package:provider/provider.dart';
import '../Controllers/FormulaireProspectController.dart';
import '../Models/prosModel.dart';

//import 'package:signature/signature.dart';
//import 'package:file_picker/file_picker.dart';

class FormulaireProspectPage extends StatefulWidget {
  final ProsModel? recup;

  const FormulaireProspectPage({super.key, this.recup});

  @override
  State<FormulaireProspectPage> createState() => _FormulaireProspectPageState();
}

class _FormulaireProspectPageState extends State<FormulaireProspectPage> {
  ProsModel? recup = ProsModel();
  g.Position? _position;
  Uint8List? exportedImage;
  bool isLoad = false;

  /*SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.red,
    exportBackgroundColor: Colors.yellowAccent,
  );*/
  List<ProvinceModel> provinces=[];
  List<ActiviteModel> activites = [];
  List<VilleModel> villes= [];
  List<ZoneModel> zones= [];
  List<CommuneModel> communes= [];
  List<OffresModel> offres = [];
  Map? user;
  GetStorage us = GetStorage();
  List selectedData = [];
  static String? provinceselectionner;
  String? villeSelect;
  String? zoneSelect;
  String? communeSelect;
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

  int timestamp = DateTime.now().millisecondsSinceEpoch;
  var nom = "Nouveau Prospect";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //recup = widget.recup;

    if (widget.recup != null) {
      nom = "Editer Prospect";
      company_name.text = widget.recup!.companyName!;
      company_adress.text = widget.recup!.companyAddress!;
      // company_type.text = widget.recup!.typeActivitiesId!.toString();
      company_phone.text = widget.recup!.companyPhone!.toString();
    }
    //getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      recuperationDataForm();
    });
  }

  recuperationDataForm() async {
    var formCtrl = context.read<FormulaireProspectController>();
    provinceRecup();

    villeReccup();

    zoneRecup();

    communeRecup();

    activityRecup();

    offreRecup();
  }

  provinceRecup() async {
    var formCtrl = context.read<FormulaireProspectController>();
    var listProvince = await formCtrl.lectureAPIstockage(
        Parametres.keyProvince, Parametres.endPointProvinces);
    formCtrl.provinces = listProvince
        .map<ProvinceModel>((e) => ProvinceModel.fromJson(e))
        .toList();
    provinces=formCtrl.provinces;
    setState(() {});
  }

  villeReccup() async {
    var formCtrl = context.read<FormulaireProspectController>();
    var listVilles = await formCtrl.lectureAPIstockage(
        Parametres.keyVilles, Parametres.endPointVilles);

    print("listvilles $listVilles");
    formCtrl.villes =
        listVilles.map<VilleModel>((e) => VilleModel.fromJson(e)).toList();
    setState(() {});
  }

  zoneRecup() async {
    var formCtrl = context.read<FormulaireProspectController>();
    var listZones = await formCtrl.lectureAPIstockage(
        Parametres.keyZones, Parametres.endPointZones);
    formCtrl.zones =
        listZones.map<ZoneModel>((e) => ZoneModel.fromJson(e)).toList();
    setState(() {});
  }

  communeRecup() async {
    var formCtrl = context.read<FormulaireProspectController>();
    var listCommunes = await formCtrl.lectureAPIstockage(
        Parametres.keyCommunes, Parametres.endPointCommunes);
    formCtrl.communes = listCommunes
        .map<CommuneModel>((e) => CommuneModel.fromJson(e))
        .toList();
    setState(() {});
  }

  activityRecup() async {
    var formCtrl = context.read<FormulaireProspectController>();
    var listActivities = await formCtrl.lectureAPIstockage(
        Parametres.keyActivities, Parametres.endPointAct);
    formCtrl.activities = listActivities
        .map<ActiviteModel>((e) => ActiviteModel.fromJson(e))
        .toList();
    setState(() {
      activites = formCtrl.activities;
    });
  }

  offreRecup() async {
    var formCtrl = context.read<FormulaireProspectController>();
    var listOffres = await formCtrl.lectureAPIstockage(
        Parametres.keyOffres, Parametres.endPointOffres);
    formCtrl.offres =
        listOffres.map<OffresModel>((e) => OffresModel.fromJson(e)).toList();
    print("OFFRES :${formCtrl.offres}");
    setState(() {
      offres = formCtrl.offres;
    });
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
                  Text("AgentId : ${user?['id'].toString()}"),
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
    print(selectedData.map((e) => e).toList());
    user = us.read('user');
    print("AGENT ID : ${user?['id']}");
    return nouveauProspect();
  }

  Widget buildCompleted() {
    return Container(child: Column());
  }

  void _getCurrentPosition() async {
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

  localisation() {
    return Column(
      children: [
        _position != null
            ? Text(_position.toString())
            : nom != "Nouveau Prospect"
                ? Text(
                    "${widget.recup!.latitude} + ${widget.recup!.longitude} ")
                : Text("Cliquer sur l'icone pour recevoir la localisation"),
        nom != "Editer Prospect"
            ? IconButton(
                onPressed: _getCurrentPosition,
                icon: Icon(Icons.location_on_outlined),
                color: Colors.orange,
              )
            : Text("")
      ],
    );
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
              var province_id=int.parse(provinceselectionner!);
               villes =  context.read<FormulaireProspectController>().villes.where((v) => v.provinceId == province_id).toList() ;
               //   await RemoteServicesVilles.getVilles(
                  //int.parse(provinceselectionner!));
                setState(() {});

            },
          ))),
    ];
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

  getData() async {
    //provinces = await RemoteServicesProv.getProvinces();
    offres = await RemoteServicesOf.getOffres();
    activites = await RemoteServicesAct.getActivity();
    if (offres != null || activites != null) {
      setState(() {
        isLoad = true;
      });
    }
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
              zones =  context.read<FormulaireProspectController>().zones.where((z) => z.villeId == ville_id).toList() ;
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
              var zone_id=int.parse(zoneSelect!);
              communes = context.read<FormulaireProspectController>().communes.where((c) => c.zoneId==zone_id).toList();
              if (communes != null) {
                setState(() {
                  isLoad = true;
                });
              }
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

  /*imgVue() {
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

  /*Widget imageProfile2() {
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
  }*/

  /*Widget bottomSheet() {
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
  }*/

  /*_getFromGallery() async {
    List<XFile>? pickedFile = await ImagePicker()
        .pickMultiImage(maxWidth: 1800, maxHeight: 1800, imageQuality: 12);
    if (pickedFile!.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(pickedFile);
      });
    }
    Navigator.pop(context);
  }*/

  /*_getFromCamera() async {
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
  }*/

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
  }*/

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
    var data = ProsModel(
      longitude: _position?.longitude.toString(),
      latitude: _position?.latitude.toString(),
      agentId: 1,//user?['id'],
      communeId: communeSelect != null ? int.parse(communeSelect!) : null,
      zoneId: zoneSelect != null ? int.parse(zoneSelect!) : null,
      villeId: villeSelect != null ? int.parse(villeSelect!) : null,
      provinceId: provinceselectionner != null
          ? int.parse(provinceselectionner!)
          : null,
      companyName: company_name.text.toString(),
      companyAddress: company_adress.text.toString(),
      typeActivitiesId: typeSelect != null ? int.parse(typeSelect!) : null,
      companyPhone: company_phone.text.toString(),
      offerId: int.parse(offreSelect!),
      state: "1",
      remoteId: timestamp.toString(),
    );
    debugPrint('DONNEE: ${data.toJson()}');
    print(save);
    if (save) {
      var brou = ProsModel(
        longitude: _position?.longitude.toString(),
        latitude: _position?.latitude.toString(),
        agentId: 1,//user?['id'],
        communeId: communeSelect != null ? int.parse(communeSelect!) : null,
        zoneId: zoneSelect != null ? int.parse(zoneSelect!) : null,
        villeId: villeSelect != null ? int.parse(villeSelect!) : null,
        provinceId: provinceselectionner != null
            ? int.parse(provinceselectionner!)
            : null,
        companyName: company_name.text.toString(),
        companyAddress: company_adress.text.toString(),
        typeActivitiesId: typeSelect != null ? int.parse(typeSelect!) : null,
        companyPhone: company_phone.text.toString(),
        offerId: int.parse(offreSelect!),
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

}
