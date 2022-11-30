import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'AuthentificationPage.dart';

class IntroPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: mainView(),
      backgroundColor: Colors.white,
      splashIconSize: 150,
      screenFunction: () async {
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
