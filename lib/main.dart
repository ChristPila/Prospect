import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Controllers/AuthentifacationController.dart';
import 'Controllers/LastThreeDayController.dart';
import 'Controllers/LastThreeMonthsController.dart';
import 'Controllers/sevenLastDaysController.dart';
import 'Views/IntroPage.dart';
import 'Controllers/ProspectController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProspectController()),
          ChangeNotifierProvider(
              create: (context) => AuthentificationController()),
          ChangeNotifierProvider(
              create: (context) => SevenLastDaysController()),
          ChangeNotifierProvider(create: (context) => LastThreeDayController()),
          ChangeNotifierProvider(
              create: (context) => LastThreeMonthsController()),
        ],
        child:MaterialApp(
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
                  headline1: TextStyle(fontSize: 30.0,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold),
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
    ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ],
        ),
      ),);
  }

}
