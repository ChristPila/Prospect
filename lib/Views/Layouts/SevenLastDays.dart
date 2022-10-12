import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Controllers/sevenLastDaysController.dart';
import '../../Models/SevenLastDaysModel.dart';
import 'dart:ui';

class SevenLastDays extends StatefulWidget {

  @override
  State<SevenLastDays> createState() => _SevenLastDaysState();
}

class _SevenLastDaysState extends State<SevenLastDays> {

  List<SevenLastDaysModel> OneData = [
    SevenLastDaysModel(jour: 'Jeudi', nombre: 850,/* color: Colors.blue*/),
    SevenLastDaysModel(jour: 'Vendredi', nombre: 600, /*color: Colors.blue*/),
    SevenLastDaysModel(jour: 'samadi', nombre: 400, /*color: Colors.blue*/),
    SevenLastDaysModel(jour: 'Lundi', nombre: 500, /*color: Colors.blue*/),
    SevenLastDaysModel(jour: 'Mardi', nombre: 400, /*color: Colors.blue*/),
    SevenLastDaysModel(jour: 'Mercredi', nombre: 600, /*color: Colors.blue*/),
  ];

  @override
  Widget build(BuildContext context) {

    List<SevenLastDaysModel> SevenLastDaysList =
        context.watch<SevenLastDaysController>().SevenLastDaysList;
    return SingleChildScrollView(
      child: Container(
        height: 280,
        margin: EdgeInsets.all(1),
        child: Card(
          shadowColor: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          child:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors : [Colors.white24, Colors.white10],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(24),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title:
              ChartTitle(
                  text: 'Rapport de 7 derniers jours'
              ),
              series: <ChartSeries> [
                ColumnSeries  <SevenLastDaysModel, String>(
                  /*pointColorMapper: (SevenLastDaysModel rapport, _)=>rapport.color,*/
                  dataSource: SevenLastDaysList,
                  xValueMapper: (SevenLastDaysModel rapport, _)=>rapport.jourFormatted,
                  yValueMapper: (SevenLastDaysModel rapport, _)=>rapport.nombre,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

