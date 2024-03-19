import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class WillAdditionalInfoScreen extends StatefulWidget {
  _WillAdditionalInfoScreenState createState() => _WillAdditionalInfoScreenState();
}

class _WillAdditionalInfoScreenState extends State<WillAdditionalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
    );
  }
}