import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_check_screen.dart';
import 'package:frontend/screens/will/will_viewer_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/widgets/common_text_widget.dart';

class WillRecordingScreen extends StatefulWidget {
  _WillRecordingScreenState createState() => _WillRecordingScreenState();
}

class _WillRecordingScreenState extends State<WillRecordingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "녹음하기",
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ]),
            ),
            Center(
              child: Ink(
                width: 100,
                height: 100,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: themeColour3,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_voice,
                    color: themeColour5,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Text("일시정지"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WillCheckScreen(),
                        ),
                      );
                    },
                    child: const Text("저장"))
              ],
            ),
          ]),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        child: TextButtonWidget(
          preText: '이전',
          nextText: '기록하기',
          nextPage: WillViewerScreen(),
        ),
      ),
    );
  }
}
