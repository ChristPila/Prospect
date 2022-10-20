import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistique extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height:140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardVisite(),
          cardBrouillons(),
        ],
      ),
    );
  }

  cardVisite(){
    return Expanded(
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        ),
        child:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors : [Colors.black, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children:[
                SizedBox(height: 7),
                Icon(
                  Icons.people,
                  size: 68,
                  color: Colors.deepOrange,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Visites : ",
                      style:
                      TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange),
                    ),
                    Text("50",
                      style:
                      TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange, fontWeight: FontWeight.bold
                      ),
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

  cardBrouillons(){
    return Expanded(
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        ),
        child:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors : [Colors.black, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children:[
                SizedBox(height: 7),
                Icon(
                  Icons.drafts_outlined,
                  size: 68,
                  color: Colors.deepOrange,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Brouillons : ",
                      style:
                      TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange),
                    ),
                    Text("50",
                      style:
                      TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange, fontWeight: FontWeight.bold
                      ),
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

