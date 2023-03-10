import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controllers/LastThreeWeeksController.dart';
import '../../Models/LastThreeWeeksModel.dart';

class WeekTab extends StatefulWidget {

  @override
  State<WeekTab> createState() => _WeekTabState();
}

class _WeekTabState extends State<WeekTab> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LastThreeWeeksController>().getReportWeekData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: listRapportsVue(),
    );
  }
  listRapportsVue() {
    List<LastThreeWeeksModel> LastThreeDaysList =
        context.watch<LastThreeWeeksController>().lastThreeWeeksList;
    return ListView.builder(
        itemCount: LastThreeDaysList.length,
        padding: EdgeInsets.all(50),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          LastThreeWeeksModel rapport = LastThreeDaysList[index];
          return Container(
            width: 400,
            child: Card(
              shadowColor: Colors.black,
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.deepOrangeAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " La semaine ${rapport.semaine} : ",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            " ${rapport.nombre}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

