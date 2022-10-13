import 'package:get_storage/get_storage.dart';
import 'package:prospect/Controllers/AuthentifacationController.dart';
import 'package:prospect/Controllers/ProspectController.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prospect/Views/FormulaireProspectPage.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(create: (context) => ProspectController())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Color.fromRGBO(255, 102, 0, 1),
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            )),
        home: Prospect(),
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
            Image.asset(
              'assets/icon_orange.png',
              width: 200,
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthentificationController()),
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
            accentColor: Colors.lightBlue,
            textTheme: TextTheme(
                headline1: TextStyle(fontSize: 30.0, color: Colors.lightBlue, fontWeight: FontWeight.bold),
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
