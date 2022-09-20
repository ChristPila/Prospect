import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prospect/utils/utilitaires.dart';
import 'package:prospect/vue/ListeProspect.dart';
import 'package:provider/provider.dart';

import 'controller/ProspectController.dart';

void main() async{
  await GetStorage.init(Utilitaires.STOCKAGE_VERSION);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProspectController()),
        ],
        child:MaterialApp(
          title: 'ProspectAppl',
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
          home: ListeProspect(),
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
      ),
    );
  }
}
