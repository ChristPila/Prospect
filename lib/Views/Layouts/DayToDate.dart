import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Controllers/DayToDateController.dart';
import '../../Models/DayToDateModel.dart';

class DayToDate extends StatefulWidget {

  @override
  State<DayToDate> createState() => _DayToDateState();
}

class _DayToDateState extends State<DayToDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: EdgeInsets.all(0),
      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white24, Colors.white10],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: daytodateChart(),
        ),
      ),
    );
  }

  daytodateChart() {
    DayToDateModel rapportGlobale =
        context.watch<DayToDateController>().raportDayToDate;
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),

      title:
      ChartTitle(
          text: 'Day to Date',
      ),

      series: <ChartSeries>[
        ColumnSeries<RapportSemaineActuelle, String>(
          dataSource: rapportGlobale.rapportSemaineActuelle ?? [],
          xValueMapper: (RapportSemaineActuelle rapport, _) {
            return rapport.jourFormatted;
          },
          yValueMapper: (RapportSemaineActuelle rapport, _) => rapport.nombre,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: 'Semaine actuelle', color: Color.fromRGBO(8, 142, 255, 1)
        ),
        ColumnSeries<RapportSemainePassee, String>(
          dataSource: rapportGlobale.rapportSemainePassee ?? [],
          xValueMapper: (RapportSemainePassee rapport, _) =>
              rapport.jourFormatted,
          yValueMapper: (RapportSemainePassee rapport, _) => rapport.nombre,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          name: 'Semaine passée',
        ),
      ],
    );
  }
}
