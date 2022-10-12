import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/AuthentifacationController.dart';
import '../Models/UserModel.dart';
import 'HomePage.dart';
import 'Layouts/ProgressHUD.dart';

class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  TextEditingController email = TextEditingController(text: "admin@admin.com");
  TextEditingController password = TextEditingController(text: "123456");

  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  UserModel? userModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userModel = new UserModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthentificationController>().session();
      var session = context.read<AuthentificationController>().utilisateur;
      print("voici la session: ${session}");
      if (session != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return HomePage();
        }));
        return;
      } else {
        return null;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Prospect",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => userModel!.email = input,
                          validator: (input) => !input!.contains('@')
                              ? "Email Id should be valid"
                              : null,
                          decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: password,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          keyboardType: TextInputType.text,
                          validator: (input) => input!.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () async {
                            /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                              return HomePage();

                            }));*/
                            if (validateAndSave()) {
                              Map data = {
                                "email": email.text,
                                "password": password.text
                              };
                              print(data);
                              // return ;

                              setState(() {
                                isApiCallProcess = true;
                              });

                              var value = await context
                                  .read<AuthentificationController>()
                                  .authentifier(data);
                              setState(() {
                                isApiCallProcess = false;
                              });
                              if (value != null) {
                                final snackBar =
                                    SnackBar(content: Text("Authentification réussie"));
                                scaffoldKey.currentState!
                                    .showSnackBar(snackBar);

                                var session = context
                                    .read<AuthentificationController>()
                                    .session();

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return HomePage();
                                }));
                              } else {
                                final snackBar =
                                    SnackBar(content: Text('Problème de connexion'));
                                scaffoldKey.currentState!
                                    .showSnackBar(snackBar);
                              };
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;

    print(form!.validate());
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
    //return true;
  }
}
