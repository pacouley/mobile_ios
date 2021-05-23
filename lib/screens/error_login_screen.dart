import 'package:flutter/material.dart';

class ErrorLoginScreen extends StatefulWidget {
  @override
  _ErrorLoginScreenState createState() => _ErrorLoginScreenState();
}

class _ErrorLoginScreenState extends State<ErrorLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close)),
                ),
                Text(
                  'ERREUR !',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(height: 7,),
                Text(
                  'Les informations entrées sont incorrectes, veuillez réessayer.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
