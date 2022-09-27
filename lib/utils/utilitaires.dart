import 'dart:ui';

import 'package:flutter/material.dart';

class Utilitaires {
  static const Color DEFAULT_COLOR = Colors.orange;

  // faire ipconfig (ifconfig sur Mac) pour recuperer votre IP de la machine
  // et mettre à jour
  static const String HOST_URL = "10.224.196.156";
  static const String STOCKAGE_VERSION ="V25";

  static String formatAmount(double valeurNumerique) {
    // cette methode peut etre etre remplacée par le package Intl
    // qui offre mieux et gerer plusieurs fonctionnalités
    //https://pub.dev/packages/intl
    String valeurNumeriqueTemp = valeurNumerique.toInt().toString();
    String priceInText = "";
    int counter = 0;
    for (int i = (valeurNumeriqueTemp.length - 1); i >= 0; i--) {
      counter++;
      String str = valeurNumeriqueTemp[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }
}
