import 'package:get_storage/get_storage.dart';
import 'package:prospect/Views/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Controllers/AuthentifacationController.dart';
import 'Controllers/LastThreeDayController.dart';
import 'Controllers/sevenLastDaysController.dart';
import 'Views/IntroPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthentificationController()),
        ChangeNotifierProvider(create: (context) => SevenLastDaysController()),
        ChangeNotifierProvider(create: (context) => LastThreeDayController()),
      ],
      child: MaterialApp(
        title: 'Prospect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 0,
              foregroundColor: Colors.white,
            ),
            accentColor: Colors.deepOrange,
            textTheme: TextTheme(
                headline1: TextStyle(fontSize: 30.0, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                headline2: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                bodyText1: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black))),
       home: IntroPage(),
      )
    );
  }
}
