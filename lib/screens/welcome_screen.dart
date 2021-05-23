import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:openrlg_mobile/utililities/rounded_button.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool showSpinner = false;
  Map<String, String> headersMap = {
    'Host': 'api.openrlgapps.org',
    'Content-Length': '0',
    'Accept': '*/*',
  };

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'BIENVENUE',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  //Image.network('https://api.openrlgapps.org/logo', headers: headersMap,),
                  Image.asset("assets/images/logo_rlg.png",height: size.height * 0.20),
                  SizedBox(height: size.height * 0.05),
                  RoundedButton(
                    text: "DEMARRER",
                    press: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                          setState(() {
                            showSpinner = false;
                          });
                      }catch(e){
                        print(e);
                      }
                    },
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(29),
                  //   child: FlatButton(
                  //     color: Colors.purple,
                  //     textColor: Colors.white,
                  //     disabledColor: Colors.grey,
                  //     disabledTextColor: Colors.black,
                  //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                  //     splashColor: Colors.grey,
                  //     onPressed: () {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context){
                  //         return LoginScreen();
                  //       }));
                  //     },
                  //     child: Text(
                  //       "Démarrer",
                  //       style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
