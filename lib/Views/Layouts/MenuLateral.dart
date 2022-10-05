import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Tools/Espace.dart';
import '../AuthentificationPage.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: ListTile(
              title: Text(
                "",
                style:
                TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35 ),
              ),
            )),
        ListTile(
          leading: Icon(
            Icons.people,
          ),
          title: const Text('Visites'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.drafts_outlined,
          ),
          title: const Text('Brouillons'),
          onTap: () {

          },
        ),
        ListTile(
          leading: Icon(
            Icons.work_history,
          ),
          title: const Text('Perfomances'),
          onTap: () {
          },
        ),
        Divider(
          thickness: 5,
        ),
        ListTile(
          leading: Icon(
            Icons.important_devices_rounded,
          ),
          title: const Text('Apropos'),
          onTap: () {

          },
        ),
        ListTile(
          leading: Icon(
            Icons.account_box,
          ),
          title: const Text('Profil'),
          onTap: () {

          },
        ),
        Espace(hauteur: 220),
        Divider(
          thickness: 5,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
          ),
          title: const Text('Deconnexion'),
          onTap: () {
            naviguerVersAuthentification(context);
          },
        ),
      ],
    );
  }

  naviguerVersAuthentification(context) {
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return AuthentificationPage();
    }));
  }
}
