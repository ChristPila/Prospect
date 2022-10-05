import 'package:flutter/material.dart';
import 'package:prospect/models/prosModel.dart';

class ProspectController with ChangeNotifier {
  // liste initiale
  List<ProsModel> listProspects = [];
  // focntion pour ajouter un prospect
  void ajouterProspect(ProsModel data) {
    data.id = listProspects.length + 1;
    listProspects.add(data);
    notifyListeners();
  }
}