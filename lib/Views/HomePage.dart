import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../Controllers/sevenLastDaysController.dart';
import 'Layouts/DayToDate.dart';
import 'Layouts/MenuLateral.dart';
import 'Layouts/SevenLastDays.dart';
import 'Layouts/Statistiques.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SevenLastDaysController>().getReportData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: MenuLateral(),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("Tableau de bord"),
          actions: [
            IconButton(
                onPressed: () {},
                iconSize: 40,
                icon: Icon(
                  Icons.refresh,
                  size: 30,
                )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 11),
              Statistique(),
              SevenLastDays(),
              DayToDate(),
            ],
          ),
        ),
      ),
    );
  }
}


