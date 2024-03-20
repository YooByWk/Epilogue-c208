import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_widgets.dart';

class WillAdditionalInfoScreen extends StatefulWidget {
  _WillAdditionalInfoScreenState createState() =>
      _WillAdditionalInfoScreenState();
}

class _WillAdditionalInfoScreenState extends State<WillAdditionalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 20,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: "연명치료 여부",
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  ChoiceButtonWidget(text: "희망"),
                  ChoiceButtonWidget(text: "미희망")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
