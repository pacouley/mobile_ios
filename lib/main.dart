import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:openrlg_mobile/screens/account_screen.dart';
import 'package:openrlg_mobile/screens/blogs_screen.dart';
import 'package:openrlg_mobile/screens/login_screen.dart';
import 'package:openrlg_mobile/screens/manage_password_screen.dart';
import 'package:openrlg_mobile/screens/welcome_screen.dart';
import 'package:openrlg_mobile/utililities/constants.dart';
import 'package:openrlg_mobile/screens/menu_screen.dart';
import 'App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await start();
  HttpOverrides.global = new MyHttpOverrides();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  }
}

Future start() async {
  await App.init();
}
