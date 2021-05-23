import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:openrlg_mobile/screens/error_init_password_screen.dart';
import 'package:openrlg_mobile/screens/login_screen.dart';
import 'package:openrlg_mobile/screens/rdv_screen.dart';
import 'package:openrlg_mobile/screens/welcome_screen.dart';
import 'package:openrlg_mobile/utililities/rounded_button.dart';
import 'package:openrlg_mobile/utililities/rounded_input_field.dart';
import 'package:openrlg_mobile/utililities/rounded_password_field.dart';
import 'package:openrlg_mobile/utililities/text_field-container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openrlg_mobile/utililities/constants.dart';
import 'package:openrlg_mobile/services/InitialisationMdpModel.dart';
import 'package:openrlg_mobile/App.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

import 'menu_screen.dart';
// import 'menu_screen.dart';

String stringValue = '';

class ManagePasswordScreen extends StatefulWidget {
  @override
  _ManagePasswordScreenState createState() => _ManagePasswordScreenState();
}

class _ManagePasswordScreenState extends State<ManagePasswordScreen> {
  TextEditingController nouveauMotDePasseCtrl;
  TextEditingController confirmeMotDePasseCtrl;
  InitialisationMdpModel _initialisationMdpModel;
  bool isHiddenPassword = true;
  bool showSpinner = false;
  String password;
  var mdp;
  String nom;
  String prenoms;
  String newMdp;
  String userMdp;

  @override
  void initState() {
    super.initState();
    nouveauMotDePasseCtrl = TextEditingController();
    confirmeMotDePasseCtrl = TextEditingController();
    getValue();
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Return String
    setState(() {
      stringValue = prefs.getString('username');
      print(stringValue);
      // return stringValue;
    });
  }

          Future<InitialisationMdpModel> InitialiserMdpUtilisateur(
              String nouveauMotPasse, String confirmeMotPasse) async{

            String apiUrl = 'https://api.openrlgapps.org/initpw';
            String cookie = await App.prefs.getString("cookie");
            String name = await App.prefs.getString("username");
            String adresseip = '';
            if(Platform.isAndroid){
              adresseip = '';
            } else if(Platform.isIOS){
              adresseip = '';
            }

            Map<String, String> headersMap4 = {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Accept': '*/*',
              'Cookie': cookie,
              'auth-user': name
            };

            final response = await http.post(apiUrl, headers: headersMap4, body: {
              'nouveauMotPasse': nouveauMotPasse,
              'confirmeMotPasse': confirmeMotPasse,
              'adresseip':adresseip,
            });

            if (response.statusCode == 200) {
              final String responseString = response.body;
              InitialisationMdpModel initialisationMdpModel = initialisationMdpModelFromJson(responseString);
              return initialisationMdpModel;
            } else {
              return null;
            }
          }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            // leading: null,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.input),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  }),
            ],
            title: Center(
              child: Text('Veuillez modifier votre mot  de passe'),
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
                        //   child: Center(
                        //     child: Text(
                        //       'MOT DE PASSE',
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 25.0,
                        //           fontStyle: FontStyle.italic),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: size.height * 0.05),
                        SizedBox(height: size.height * 0.05),
                        TextFieldContainer(
                          child: TextField(
                            obscureText: isHiddenPassword,
                            enabled: false,
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: '$stringValue',
                              icon: Icon(
                                Icons.email,
                                color: kPrimaryColor,
                              ),
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility_off),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        TextFieldContainer(
                          child: TextField(
                            controller: nouveauMotDePasseCtrl,
                            obscureText: isHiddenPassword,
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Nouveau Mot De Passe",
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
                          controller: confirmeMotDePasseCtrl,
                          labelText: 'CONFIRMER NOUVEAU MOT DE PASSE',
                          // hintText: '',
                          textAlign: TextAlign.center,
                        ),
                        RoundedButton(
                          textAlign: TextAlign.center,
                          text: "ENREGISTRER",
                          press: () async{
                            setState((){
                              showSpinner = true;
                            });
                            // print({'$username', '$password'});
                            try {
                              password = nouveauMotDePasseCtrl.text;
                              newMdp = confirmeMotDePasseCtrl.text;

                              final InitialisationMdpModel initialisationMdpModel =
                                  await InitialiserMdpUtilisateur(password, newMdp);

                              // setState(() {
                              //   _initialisationMdpModel = initialisationMdpModel;
                              //
                              // });

                              if (initialisationMdpModel == null) {
                                showMessageError();
                              }else if(password != newMdp){
                                showMessageError();
                              }else if (password == '' && newMdp == ''){
                                showMessageError();
                              } else {
                                print('$password');
                                print("confirmemdp: $newMdp");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return MenuScreen();
                                    }));
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
        ),
      ),
    );
  }

  void showMessageError() {
    showDialog(
      context: context,
      builder: (context) => ErrorInitPasswordScreen(),
    );
  }

  updatePassword(){
    Future.delayed(Duration(seconds: 3), (){
      setState(() {
        showSpinner = false;
      });
      print("enregister fin");
      Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
    });

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
