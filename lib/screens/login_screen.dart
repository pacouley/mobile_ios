import 'dart:io';
import 'package:openrlg_mobile/screens/menu_screen.dart';
import 'package:openrlg_mobile/screens/rdv_screen.dart';
import 'package:openrlg_mobile/services/RdvModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:openrlg_mobile/services/AuthenticationModel.dart';
import 'package:openrlg_mobile/services/loginUser.dart';
import 'package:openrlg_mobile/utililities/text_field-container.dart';
import 'package:openrlg_mobile/utililities/constants.dart';
import 'package:openrlg_mobile/utililities/rounded_button.dart';
import 'package:openrlg_mobile/utililities/rounded_input_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:openrlg_mobile/utililities/rounded_password_field.dart';
import 'package:openrlg_mobile/services/networking.dart';

import '../App.dart';
import 'error_login_screen.dart';
import 'manage_password_screen.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String usernamePref;
String userCookie;
String nomPref;
String prenomsPref;
bool firstConnect;

Map<String, String> headersMap2 = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Accept': '*/*',
  'Cookie': userCookie,
  'auth-user': usernamePref
};

Future<RdvModel> RdvUtilisateur() async {
  final String apiUrl = 'https://api.openrlgapps.org/rdv';

  print("coockie: " + userCookie);
  print("auth-user: " + usernamePref);

  final response = await http.get(
    apiUrl,
    headers: headersMap2,
  );

  if (response.statusCode == 200) {
    //final String responseString = jsonDecode(response.body);

    //print("rrrrrrrrrrrrr"+ jsonDecode(response.body).toString());

    var data = json.decode(json.encode(response.body.toString()));

    return RdvModelFromJson(data.toString());
  } else {
    return null;
  }
}

Map<String, String> headersMap = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Accept': '*/*',
};

Future<AuthenticationModel> AuthentifierUtilisateur(
    String username, String password) async {
  final String apiUrl = 'https://api.openrlgapps.org/auth';

  final response = await http.post(apiUrl, headers: headersMap, body: {
    'username': username,
    'password': password,
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    print("header:" + response.headers["set-cookie"]);
    AuthenticationModel authModel = authenticationModelFromJson(responseString);
    usernamePref = authModel.username;
    firstConnect = authModel.firstconnect;
    userCookie = response.headers["set-cookie"];
    print("username:  " + usernamePref);
    authModel.cookie = userCookie;
    return authModel;
  } else {
    return null;
  }
}

RdvModel rdvModel;

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  AuthenticationModel _authenticationModel;
  bool showSpinner = false;

  TextEditingController loginCtrl;
  TextEditingController passwordCtrl;

  @override
  initState() {
    loginCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    // DisplayLogo(),
                    Image.asset("assets/images/logo_rlg.png",height: size.height * 0.20),
                    // SvgPicture.asset(
                    //   "assets/icons/chat.svg",
                    //   height: size.height * 0.45,
                    // ),
                    SizedBox(height: size.height * 0.05),
                    RoundedInputField(
                      controller: loginCtrl,
                      hintText: "Adresse Mail",
                    ),
                    TextFieldContainer(
                      child: TextField(
                        controller : passwordCtrl,
                        obscureText: isHiddenPassword,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Mot De Passe",
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
                    RoundedButton(
                      text: "SE CONNECTER",
                      press: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        // print({'$username', '$password'});
                        try {
                          final AuthenticationModel authenticationModel =
                              await AuthentifierUtilisateur(loginCtrl.text, passwordCtrl.text);


                          setState(() {
                            _authenticationModel = authenticationModel;

                          });

                          if (_authenticationModel == null) {
                            showMessageError();
                          } else {
                            print("authentifié avec succes");
                            print('firstConnect: $firstConnect');
                            await saveValue(authenticationModel.username, authenticationModel.cookie, authenticationModel.nom , authenticationModel.prenom);
                            getValue();

                            if(firstConnect == true){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ManagePasswordScreen();
                                  }));
                            }
                            if(firstConnect == false){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MenuScreen();
                                  }));
                            }

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
        builder: (context) =>  ErrorLoginScreen(),
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

  saveValue(String user, String cookie, String nom, String prenoms) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance ();
    await App.prefs.setString('username', usernamePref);
    await App.prefs.setString('cookie', userCookie);
    await App.prefs.setString('nom', nomPref);
    await App.prefs.setString('prenom', prenomsPref);
    // print(usernamePref);
  }

  getValue() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance ();
    // Return String
    setState(() {
      String stringValue = App.prefs.getString('username');
      print(stringValue);

      String stringValueNom = App.prefs.getString('nom');
      print(stringValueNom);

      String stringValuePrenoms = App.prefs.getString('prenom');
      print(stringValuePrenoms);

      print("Cooooooooockie" + App.prefs.getString('cookie'));
      // return stringValue;
    });
  }
}
