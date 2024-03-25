import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_recording_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';

class WillWitnessScreen extends StatefulWidget {
  _WillWitnessScreenState createState() => _WillWitnessScreenState();
}

class _WillWitnessScreenState extends State<WillWitnessScreen> {
  int counter = 1;
  List<Widget> witnessList = [WillWitnessWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: TextWidget(
                text: "디지털 유언장 \n증인 정보 입력",
                fontSize: 50,
                fontWeight: FontWeight.w700,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  '최대 5인 지정 가능',
                  style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Column(
              children: List.generate(counter, (index) {
                return Column(
                  children: [
                    witnessList[index],
                    Container(
                        child: (index > 0)
                            ? ElevatedButton(
                                onPressed: () => delete(index),
                                child: Text('삭제'))
                            : null),
                  ],
                );
              }),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                child: (counter < 5)
                    ? ElevatedButton(onPressed: increment, child: Text('추가'))
                    : null),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 100,
        child: TextButtonWidget(
          preText: '이전',
          nextText: '다음',
          nextPage: WillRecordingScreen(),
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      if (counter < 5) {
        counter++;
        witnessList.add(WillWitnessWidget());
      }
    });
  }

  void delete(int index) {
    setState(() {
      if (counter > 1 && index < witnessList.length) {
        counter--;
        debugPrint('$index');
        witnessList.removeAt(index);
      }
    });
  }
}
