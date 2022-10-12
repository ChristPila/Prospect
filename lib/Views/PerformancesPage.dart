import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'Layouts/DayTab.dart';

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
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mes Performances', style: TextStyle(color: Colors.white),),
          backgroundColor:Colors.deepOrange,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return HomePage();
                  }));
                },
                iconSize: 40,
                icon: Icon(
                  Icons.home,
                  size: 30,color: Colors.white,
                )
            )
          ],
        ),
        body: Column(
          children: [
            TabBar(
                tabs: [
                  Tab(
                    child: Text('Jour', style: TextStyle(color: Colors.black)),
                  ),
                ]
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    DayTab(),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}


