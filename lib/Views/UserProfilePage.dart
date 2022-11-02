import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prospect/Views/HomePage.dart';
import '../Tools/Utilitaires.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  GetStorage userInfo = GetStorage(Utilitaires.STOCKAGE_VERSION);
  Map<String, dynamic> userInfoMap = {};
  String? nomComplet;
  String? Email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.deepOrangeAccent,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Entete(),
              SizedBox(
                height: 50,
              ),
              ImageUser(),
              SizedBox(
                height: 90,
              ),
              NomCompletUser(),
              SizedBox(
                height: 35,
              ),
              EmailUser(),
            ],
          ),
        ),
      ),
    );
  }

  Entete(){
    return Text(
      "Mon Profil",
      style: Theme.of(context).textTheme.headline5,
    );
  }
  NomCompletUser() {
    userInfoMap = userInfo.read("user");
    nomComplet = userInfoMap["name"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nom Complet",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "$nomComplet",
          style: Theme.of(context).textTheme.headline3,
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }

  ImageUser(){
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                    ))),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: Colors.deepOrangeAccent,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  EmailUser() {
    userInfoMap = userInfo.read("user");
    Email =userInfoMap['email'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "$Email",
          style: Theme.of(context).textTheme.headline3,
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
