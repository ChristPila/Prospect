import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prospect/Controllers/FormulaireProspectController.dart';
import 'package:prospect/Tools/Parametres.dart';
import 'package:prospect/Views/FormulaireProspectPage.dart';
import 'package:prospect/Views/HomePage.dart';
import 'package:provider/provider.dart';
import 'Controllers/AuthentifacationController.dart';
import 'Controllers/DayToDateController.dart';
import 'Controllers/GetAllProspectsController.dart';
import 'Controllers/LastThreeDayController.dart';
import 'Controllers/LastThreeMonthsController.dart';
import 'Controllers/LastThreeWeeksController.dart';
import 'Controllers/sevenLastDaysController.dart';
import 'Views/IntroPage.dart';
import 'Controllers/ProspectController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(Parametres.STOCKAGE_VERSION);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthentificationController()),
        ChangeNotifierProvider(create: (context) => SevenLastDaysController()),
        ChangeNotifierProvider(create: (context) => LastThreeDayController()),
        ChangeNotifierProvider(create: (context) => LastThreeMonthsController()),
        ChangeNotifierProvider(create: (context) => LastThreeWeeksController()),
        ChangeNotifierProvider(create: (context) => DayToDateController()),
        ChangeNotifierProvider(create: (context) => ProspectController()),
        ChangeNotifierProvider(create: (context) => AuthentificationController()),
        ChangeNotifierProvider( create: (context) => SevenLastDaysController()),
        ChangeNotifierProvider(create: (context) => LastThreeDayController()),
        ChangeNotifierProvider( create: (context) => LastThreeMonthsController()),
        ChangeNotifierProvider(create: (context) => FormulaireProspectController()),
        ChangeNotifierProvider(create: (context) => GetAllProspectsController()),
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
            textTheme: TextTheme(
                headline1: TextStyle(fontSize: 30.0, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                headline3: TextStyle(fontSize: 20.0, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                headline6: TextStyle(fontSize: 17.0, color: Colors.black54, fontWeight: FontWeight.bold),
                headline5 : TextStyle(fontSize: 25.0, color: Colors.black54, fontWeight: FontWeight.bold),
                headline2: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                bodyText1: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange)),
       home: HomePage(),
      )
    );
  }
}
