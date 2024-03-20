import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_check_screen.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/widgets/will_viewer_widget.dart';

class WillViewerScreen extends StatefulWidget {
  _WillViewerScreenState createState() => _WillViewerScreenState();
}

class _WillViewerScreenState extends State<WillViewerScreen> {
  int counter = 1;

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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "디지털 유언장 \n열람인 지정",
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ]),
            ),
            Column(
              children: List.generate(counter, (index) {
                return Column(
                  children: [
                    WillViewerWidget(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillCheckScreen(),
                    ),
                  ),
                  child: const Text('이전'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillSelectMemorialScreen(),
                    ),
                  ),
                  child: const Text('다음'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      if (counter < 5) {
        counter++;
      }
    });
  }

  void delete(int index) {
    setState(() {
      if (counter > 1) {
        counter--;
        if (index > 0) {
          (context as Element).markNeedsBuild();
        }
      }
    });
  }
}
