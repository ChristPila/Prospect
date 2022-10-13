import 'package:flutter/material.dart';
import 'AuthentificationPage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);
  @override
  State<IntroPage> createState() => _IntroPageState();
}
class _IntroPageState extends State<IntroPage> {
  bool afficher = false;

  @override
  void initState() {
    super.initState();
    animationRetarde();
  }
  animationRetarde() async {
    await Future.delayed(Duration(milliseconds: 500));
    afficher = true;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AuthentificationPage();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: afficher ? 1 : 0,
      duration: Duration(seconds: 2),
      child: Scaffold(
          body:Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon_orange.png',
                    width: 200,
                  ),
                ],
              ),
            ),
          )

      ),
    );
  }
}





