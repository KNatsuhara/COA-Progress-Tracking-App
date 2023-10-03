import 'package:coa_progress_tracking_app/auth/auth_page.dart';
import 'package:coa_progress_tracking_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/main_page.dart';
import 'package:geolocator/geolocator.dart';
import 'pages/settings_page.dart';
import 'pages/location_tracking_page.dart';
import 'dart:async';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COA Progress App',
      theme: ThemeData(
        primaryColor: Colors.amber[900],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainPage(),
    );
  }
}
