import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'E:pilogue',
      theme : ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home : LoginScreen() // Change this to the home screen of your app
    );
  }
}
