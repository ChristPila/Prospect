import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Controllers/AuthentifacationController.dart';
import 'AuthentificationPage.dart';
import 'HomePage.dart';

class IntroPage extends StatefulWidget {

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  verifierSiDejaConnecte(){
    context.read<AuthentificationController>().session();
    var session = context.read<AuthentificationController>().utilisateur;
    if (session != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: mainView(),
      backgroundColor: Colors.white,
      splashIconSize: 150,
      screenFunction: () async {
        var homeRoute=verifierSiDejaConnecte();
        if(homeRoute!=null) return homeRoute;
        return AuthentificationPage();
      },
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      duration: 1000,
      animationDuration: Duration(milliseconds: 2500),
    );
  }

  mainView() {
    return Column(
      children: [
        Expanded(
          child: iconAplication(),
        )
      ],
    );
  }

  iconAplication() {
    return Image.asset(
      'assets/icon_orange.png',
    );
  }
}
