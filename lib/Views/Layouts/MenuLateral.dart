import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prospect/Views/FormulaireProspectPage.dart';
import 'package:provider/provider.dart';
import '../../Controllers/AuthentifacationController.dart';
import '../AuthentificationPage.dart';
import '../ListeProspectPage.dart';
import '../PerformancesPage.dart';
import '../UserProfilePage.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepOrange),
            child: ListTile(
              title: Text(
                "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35),
              ),
            )),
        ListTile(
          leading: Icon(
            Icons.people,
          ),
          title: const Text('Créer Une visite'),
          onTap: () {
           naviguerVersVisite(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.drafts_outlined,
          ),
          title: const Text('Mes Prospects'),
          onTap: () {
            naviguerVersBrouillons(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.work_history,
          ),
          title: const Text('Mes Perfomances'),
          onTap: () {
            naviguerVersPerformance(context);
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
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.account_box,
          ),
          title: const Text('Profil'),
          onTap: () {
            naviguerVersProfilUser(context);
          },
        ),
        //Espace(hauteur: 220),
        Spacer(),
        Divider(
          thickness: 5,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
          ),
          title: const Text('Deconnexion'),
          onTap: () async {
            context.read<AuthentificationController>().finSession();
            Navigator.pop(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthentificationPage()),
                (Route route) => false);
          },
        ),
      ],
    );
  }

  naviguerVersPerformance(context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PerformancesPages();
    }));
  }

  naviguerVersBrouillons(context) async {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ListeProspectPage();
    }));

  }

  naviguerVersVisite(context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return FormulaireProspectPage();
    }));
  }

  naviguerVersProfilUser(context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return UserProfilePage();
    }));
  }
}
