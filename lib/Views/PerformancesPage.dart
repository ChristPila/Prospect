import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'Layouts/DayTab.dart';
import 'Layouts/MonthTab.dart';
import 'Layouts/WeekTab.dart';

class PerformancesPages extends StatefulWidget {
  const PerformancesPages({Key? key}) : super(key: key);

  @override
  State<PerformancesPages> createState() => _PerformancesPagesState();
}

class _PerformancesPagesState extends State<PerformancesPages> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mes Performances', style: TextStyle(color: Colors.white),),
          backgroundColor:Colors.deepOrange,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
          ),
        ),
        body: Column(
          children: [
            TabBar(
                tabs: [
                  Tab(
                    child: Text('Jour', style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                      child: Text('Semaine', style: TextStyle(color: Colors.black))
                  ),
                  Tab(
                    child: Text('Mois', style: TextStyle(color: Colors.black)),
                  ),
                ]
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    DayTab(),
                    WeekTab(),
                    MonthTab()
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}


