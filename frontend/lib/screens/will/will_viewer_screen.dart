import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';

class WillViewerScreen extends StatelessWidget {
  const WillViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(children: [
        const Text("디지털 유언장 열람인 지정"),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("이전")),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WillSelectMemorialScreen(),
                ),
              ),
              child: const Text('다음'),
            )
          ],
        ),
      ]),
    );
  }
}
