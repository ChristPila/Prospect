import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controllers/LastThreeMonthsController.dart';
import '../../Models/LastThreeMonthsModel.dart';


class MonthTab extends StatefulWidget {
  const MonthTab({Key? key}) : super(key: key);

  @override
  State<MonthTab> createState() => _MonthTabState();
}

class _MonthTabState extends State<MonthTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LastThreeMonthsController>().getReportMonthData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: listRapportsVue(),
    );
  }

  listRapportsVue() {
    List<LastThreeMonthsModel> lastThreeMonthsList =
        context.watch<LastThreeMonthsController>().lastThreeMonthsList;
    return ListView.builder(
        itemCount: lastThreeMonthsList.length,
        padding: EdgeInsets.all(60),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          LastThreeMonthsModel rapport = lastThreeMonthsList[index];
          return Container(
            width: 300,
            child: Card(
              shadowColor: Colors.black,
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepOrange, Colors.deepOrangeAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                            " ${rapport.moisFormatted} : ",
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

