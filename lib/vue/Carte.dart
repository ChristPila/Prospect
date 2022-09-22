import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prospect/vue/ProspectDetail.dart';
import '../utils/utilitaires.dart';

class Carte extends StatefulWidget {
  const  Carte({Key? key, required this.title}): super(key: key);
  final String title;


  @override
  State<Carte> createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Afficher la carte"),
      centerTitle: true,
      backgroundColor: Utilitaires.DEFAULT_COLOR,
    ),
  );
  }
}
