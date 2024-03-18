import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_check_screen.dart';

class WillRecordingScreen extends StatelessWidget {
  const WillRecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(children: [
        const Text("녹음하기"),
        Ink(
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
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("이전"))
      ]),
    );
  }
}
