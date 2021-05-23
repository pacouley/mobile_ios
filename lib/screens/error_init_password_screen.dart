import 'package:flutter/material.dart';

class ErrorInitPasswordScreen extends StatefulWidget {
  @override
  _ErrorInitPasswordScreenState createState() => _ErrorInitPasswordScreenState();
}

class _ErrorInitPasswordScreenState extends State<ErrorInitPasswordScreen> {
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
                  "Une erreur s'est produite, veuillez réessayer.",
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
