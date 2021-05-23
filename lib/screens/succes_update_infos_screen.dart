import 'package:flutter/material.dart';

class SuccesUpdateInfosScreen extends StatefulWidget {
  @override
  _SuccesUpdateInfosScreenState createState() => _SuccesUpdateInfosScreenState();
}

class _SuccesUpdateInfosScreenState extends State<SuccesUpdateInfosScreen> {
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
                  'SUPER !',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                SizedBox(height: 7,),
                Text(
                  'Vos informations ont été enregistrées.',
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
