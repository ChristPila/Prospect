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
  TextEditingController email = TextEditingController(text: "divinenagonjo@gmail.com");
  TextEditingController password = TextEditingController(text: "123456789");

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            child :formulaireAuthentification(),
          ),
        ],
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
  }

  /* Voici le formulaire pour l'authentificatio de l'utilisateur */
  formulaireAuthentification(){
    return Form(
      key: globalFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            entete(),
            SizedBox(height: 20),
            champDeSaisieEmail(),
            SizedBox(height: 20),
            champDeSaisiePassword(),
            SizedBox(height: 30),
            buttonDeValidation(),
          ],
        ),
      ),
    );
  }

  /* Voici l'entête de l'appplication
   * qui est appelé dans la fonction formulaire authentification */
  entete(){
    return Text(
      "PROSPECT",
      style: Theme.of(context).textTheme.headline1,
    );
  }

  /* Voici les codes pour la constuction de champ de saisie EMAIL
   * qui est appelé dans la fonction formulaire authentification */
  champDeSaisieEmail(){
    return new TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => userModel!.email = input,
      validator: (input) => !input!.contains('@')
          ? "Votre adresse email est un valide"
          : null,
      decoration: new InputDecoration(
        hintText: "Entrez votre adresse email",
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
    );
  }

  /* Voici les codes pour la constuction de champ de saisie MOT DE PASSE
   * qui est appelé dans la fonction formulaire authentification */
  champDeSaisiePassword(){
    return new TextFormField(
      controller: password,
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary),
      keyboardType: TextInputType.text,
      validator: (input) => input!.length < 5
          ? "le mot de passe doit avoir plus de 5 caractères"
          : null,
      obscureText: hidePassword,
      decoration: new InputDecoration(
        hintText: "Entrez votre mot de passe",
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
    );
  }

  /* Voici les codes pour la constuction du button validation
   * qui est appelé dans la fonction formulaire authentification */
  buttonDeValidation(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () async {
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:Text('Authentification réussie !'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                    var session = context
                        .read<AuthentificationController>()
                        .session();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                          return HomePage();
                        }));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:Text('Problème de connexion !'),
                        duration: Duration(seconds: 10),
                      ),
                    );
                  };
                }
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange, shadowColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
