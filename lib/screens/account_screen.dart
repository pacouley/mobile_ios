

import 'package:flutter/material.dart';
import 'package:openrlg_mobile/screens/login_screen.dart';
import 'package:openrlg_mobile/screens/succes_update_infos_screen.dart';
import 'package:openrlg_mobile/screens/welcome_screen.dart';
import 'package:openrlg_mobile/services/UpdateInfosModel.dart';
import 'package:openrlg_mobile/utililities/constants.dart';
import 'package:openrlg_mobile/utililities/rounded_button.dart';
import 'package:openrlg_mobile/utililities/rounded_input_field.dart';
import 'package:openrlg_mobile/utililities/rounded_password_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:openrlg_mobile/utililities/text_field-container.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:openrlg_mobile/services/InfosModel.dart';
import 'package:http/http.dart' as http;
import 'package:openrlg_mobile/screens/rdv_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../App.dart';
import 'error_init_password_screen.dart';

// import 'menu_screen.dart';

String emailPref;
String nomPref;
String prenomsPref;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}
String usernamePreff;



class _AccountScreenState extends State<AccountScreen> {
  // GlobalKey _scaffold = GlobalKey();
  bool isHiddenPassword = true;
  bool showSpinner = false;
  String nom;
  String prenoms;
  String newMdp;

  String userNom;
  String userPrenoms;
  String userEmail;
  String userMdp;

  @override
  initState() {
    super.initState();
    InfosUtilisateur();
    getValue();
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Return String
    setState(() {
      emailPref = prefs.getString('username');
      print(emailPref);

      nomPref = prefs.getString('nom');
      print(nomPref);

      prenomsPref = prefs.getString('prenom');
      print(prenomsPref);
    });
  }

  Future<InfosModel> InfosUtilisateur() async {
    String cookie = await App.prefs.getString("cookie");
    String name = await App.prefs.getString("username");

    Map<String, String> headersMap3 = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Cookie': cookie,
      'auth-user': name
    };
    final String apiUrl = 'https://api.openrlgapps.org/infosperso';

    final response = await http.get(apiUrl, headers: headersMap3);

    if (response.statusCode == 200) {
      setState(() {
        final String responseString = response.body;
        InfosModel infosModel = infosModelFromJson(responseString);
        nom = infosModel.nom;
        print(nom);

        prenoms = infosModel.prenom;
        print(prenoms);

        return infosModel;
      });

    } else {
      return null;
    }
  }

  Future<UpdateInfosModel> ModifierInfosUtilisateur(
      String nom, String prenom, String motpasse) async{

    String apiUrl = 'https://api.openrlgapps.org/updateinfos';
    String cookie = await App.prefs.getString("cookie");
    String name = await App.prefs.getString("username");

    Map<String, String> headersMap5 = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Cookie': cookie,
      'auth-user': name
    };

    final response = await http.post(apiUrl, headers: headersMap5, body: {
      'nom': nom,
      'prenom': prenom,
      'motpasse': motpasse,
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      UpdateInfosModel updateInfosModel = updateInfosModelFromJson(responseString);
      return updateInfosModel;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.input),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }),
        ],
        title: Center(
          child: Text('Informations personnelles'),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Center(
                    //   child: Text(
                    //     'VOS INFORMATIONS',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 30.0,
                    //         fontStyle: FontStyle.italic),
                    //   ),
                    // ),
                    // SizedBox(height: size.height * 0.05),
                    SizedBox(height: size.height * 0.05),
                    RoundedInputField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      labelText: "NOM",
                      hintText: '$nom',
                      onChanged: (value) {
                        nom = value;
                      },
                    ),
                    RoundedInputField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      labelText: "PRENOMS",
                      hintText: "$prenoms",
                      onChanged: (value) {
                        prenoms = value;
                      },
                    ),
                    RoundedInputField(
                      icon: Icons.email,
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      hintText: "$emailPref",
                      onChanged: (value) {
                      },
                    ),
                    TextFieldContainer(
                      child: TextField(
                        obscureText: isHiddenPassword,
                        onChanged: (value) {
                          userMdp = value;
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          labelText: "Nouveau Mot De Passe",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: isHiddenPassword == false
                                ? Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            )
                                : Icon(Icons.visibility_off),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    RoundedPasswordField(
                      labelText: 'Confirmer Mot De Passe',
                      // hintText: '',
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        newMdp = value;
                      },
                    ),
                    RoundedButton(
                      textAlign: TextAlign.center,
                      text: "SAUVEGARDER",
                      press: () async {
                        setState((){
                          showSpinner = true;
                        });
                        // print({'$username', '$password'});
                        try {
                          final UpdateInfosModel updateInfosModel  =
                          await ModifierInfosUtilisateur(nom, prenoms, userMdp);

                          // setState(() {
                          //   _initialisationMdpModel = initialisationMdpModel;
                          //
                          // });

                          if (userMdp != '' && newMdp != '') {
                            if(userMdp == newMdp){
                              if(updateInfosModel != null){
                                showMessageSucces();
                              }
                            }
                          }else if(userMdp == null || newMdp == null){
                            showMessageError();
                          }else if(userMdp != newMdp){
                            showMessageError();
                          }else if(updateInfosModel == null){
                            showMessageError();
                          }else {
                            showMessageError();
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMessageError() {
    showDialog(
      context: context,
      builder: (context)=>ErrorInitPasswordScreen(),
    );
  }

  void showMessageSucces() {
    showDialog(
      context: context,
      builder: (context)=>SuccesUpdateInfosScreen (),
    );
  }

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
