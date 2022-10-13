import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prospect/Models/SevenLastDaysModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DayToDate extends StatefulWidget {

  @override
  State<DayToDate> createState() => _DayToDateState();
}
class _DayToDateState extends State<DayToDate> {

  List<SevenLastDaysModel> OneData = [
    SevenLastDaysModel(jour: 'Jeudi', nombre: 850,/* color: Colors.blue*/),
    SevenLastDaysModel(jour: 'Vendredi', nombre: 300, /*color: Colors.blue*/),
    SevenLastDaysModel(jour: 'samadi', nombre: 400, /*color: Colors.blue*/),
  ];

  List<SevenLastDaysModel> TwoData = [
    SevenLastDaysModel(jour: 'Jeudi', nombre: 700, /*color: Colors.red*/),
    SevenLastDaysModel(jour: 'Vendredi', nombre: 600, /*color: Colors.red*/),
    SevenLastDaysModel(jour: 'samadi', nombre: 500, /*color: Colors.red*/),

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: EdgeInsets.all(0),
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
              text: 'Day to Date',
            ),
            series: <ChartSeries> [
              ColumnSeries  <SevenLastDaysModel, String>(
                /*pointColorMapper: (SevenLastDaysModel rapport, _)=>rapport.color,*/
                dataSource: OneData,
                xValueMapper: (SevenLastDaysModel rapport, _)=>rapport.jour,
                yValueMapper: (SevenLastDaysModel rapport, _)=>rapport.nombre,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
              ColumnSeries  <SevenLastDaysModel, String>(
                /*pointColorMapper: (SevenLastDaysModel rapport, _)=>rapport.color,*/
                dataSource: TwoData,
                xValueMapper: (SevenLastDaysModel rapport, _)=>rapport.jour,
                yValueMapper: (SevenLastDaysModel rapport, _)=>rapport.nombre,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

