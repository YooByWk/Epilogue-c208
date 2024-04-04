import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_viewer_screen.dart';

class WillCheckScreen extends StatelessWidget {
  const WillCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(children: [
        const Text("나의 유언 확인하기"),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("이전")),
            TextButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: const Text('기록된 유언은 블록 체인에 기록됩니다. 정말 생성하시겠습니까?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('돌아가기'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WillViewerScreen(),
                        ),),
                        child: const Text('생성하기'),
                      ),
                    ],
                  ),
                ),
                child: const Text("완료"))
          ],
        ),
      ]),
    );
  }
}
