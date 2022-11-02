import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../FormulaireProspectPage.dart';
import '../ListeProspectPage.dart';

class Statistique extends StatefulWidget {
  final int nbrevisits;
  final int nbreBrouillons;

  Statistique(
      {super.key, required this.nbreBrouillons, required this.nbrevisits});
  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardVisite(),
          cardBrouillons(),
        ],
      ),
    );
  }

  cardVisite() {
    return Expanded(
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FormulaireProspectPage();
                      }));
                    },
                    iconSize: 55,
                    icon: Icon(
                      Icons.people,
                      color: Colors.deepOrange,
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Visites : ",
                        style:
                            TextStyle(fontSize: 18, color: Colors.deepOrange),
                      ),
                      Text(
                        "${widget.nbrevisits}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  cardBrouillons() {
    return Expanded(
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ListeProspectPage();
                      }));
                    },
                    iconSize: 55,
                    icon: Icon(
                      Icons.drafts_outlined,
                      color: Colors.deepOrange,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Brouillons : ",
                      style: TextStyle(fontSize: 18, color: Colors.deepOrange),
                    ),
                    Text(
                      "${widget.nbreBrouillons}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange,
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
  }
}
