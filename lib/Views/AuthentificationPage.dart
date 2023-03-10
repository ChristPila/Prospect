import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/AuthentifacationController.dart';
import '../Tools/Parametres.dart';
import 'HomePage.dart';
import 'Layouts/ProgressHUD.dart';

class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  TextEditingController email =
      TextEditingController(text: Parametres.loginUser);
  TextEditingController password =
      TextEditingController(text: Parametres.loginPassword);

  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: vuePrincipale(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget vuePrincipale(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius: 20)
                ],
              ),
              child: formulaireAuthentification(),
            ),
          ),
        ],
      ),
    );
  }

  /* Voici le formulaire pour l'authentificatio de l'utilisateur */
  formulaireAuthentification() {
    return Form(
      key: globalFormKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            titreFormulaire(),
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

  /* Voici l'ent??te de l'appplication
   * qui est appel?? dans la fonction formulaire authentification */
  titreFormulaire() {
    return Text(
      "PROSPECT",
      style: Theme.of(context).textTheme.headline1,
    );
  }

  /* Voici les codes pour la constuction de champ de saisie EMAIL
   * qui est appel?? dans la fonction formulaire authentification */
  champDeSaisieEmail() {
    return new TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (input) =>
          !input!.contains('@') ? "Votre adresse email est invalide" : null,
      decoration: new InputDecoration(
        hintText: "Entrez votre adresse email",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  /* Voici les codes pour la constuction de champ de saisie MOT DE PASSE
   * qui est appel?? dans la fonction formulaire authentification */
  champDeSaisiePassword() {
    return new TextFormField(
      controller: password,
      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      keyboardType: TextInputType.text,
      validator: (input) => input!.length < 5
          ? "Le mot de passe doit contenir plus de 5 caract??res"
          : null,
      obscureText: hidePassword,
      decoration: new InputDecoration(
        hintText: "Entrez votre mot de passe",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
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
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  /* Voici les codes pour la constuction du button validation
   * qui est appel?? dans la fonction formulaire authentification */
  buttonDeValidation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => validatationFormulaire(context),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  // important de mettre ?? jour flutter pour que cette propri??t?? fonctionne
                  // commande ?? executer: flutter upgrade
                  backgroundColor: Colors.deepOrange,
                  shadowColor: Colors.black),
            ),
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

  validatationFormulaire(BuildContext context) async {
    if (validateAndSave()) {
      Map data = {"email": email.text, "password": password.text};
      print(data);
      // return ;
      lancerChargement(true);
      var status =
          await context.read<AuthentificationController>().authentifier(data);
      lancerChargement(false);

      if (status == null) {
        affichageSnack(context, msg: 'Probl??me de connexion !');
        return;
      }

      affichageSnack(context,
          msg: 'Authentification r??ussie !', textColor: Colors.deepOrange);
      await Future.delayed(Duration(milliseconds: 3500));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
    }
  }

  affichageSnack(BuildContext context,
      {required String msg,
      double duree = 3,
      Color bgColor = Colors.white,
      Color textColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
            SizedBox(
              width: 20,
            ),
            Text(msg, style: TextStyle(color: textColor)),
          ],
        ),
        duration: Duration(seconds: 5),
        backgroundColor: bgColor,
      ),
    );
  }

  lancerChargement(bool status) {
    setState(() {
      isApiCallProcess = status;
    });
  }
}
