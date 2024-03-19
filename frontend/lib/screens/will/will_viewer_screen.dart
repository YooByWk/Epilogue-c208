import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_check_screen.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';
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
          children: [
            const Text("디지털 유언장 열람인 지정"),
            const Text("최대 5인 지정"),
            Column(
              children: List.generate(counter, (index) {
                // debugPrint('추가');
                return WillViewerWidget();
              }),
            ),
            Center(
                child: (counter < 5)
                    ? ElevatedButton(onPressed: increment, child: Text('추가'))
                    : null),
            Center(
                child: (counter > 1)
                    ? ElevatedButton(onPressed: delete, child: Text('삭제'))
                    : null),
            // ElevatedButton(onPressed: increment, child: Text('추가')),
            Row(
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WillCheckScreen(),
                        ),
                      ),
                  child: const Text('이전'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.push(
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

  void delete() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }
}
