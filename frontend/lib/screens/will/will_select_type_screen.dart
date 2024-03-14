import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';
import 'package:frontend/widgets/common_button.dart';

class WillSelectTypeScreen extends StatelessWidget {
  const WillSelectTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: Text('유언장 생성하기'),
      ),
      body: Column(children: [
        Text("유언을 남기고 싶은 방법"),
        Row(
          children: [
            CommonButtonWidget(
              text: "음성 녹음",
              width: 120,
              height: 120,
              textColor: Colors.black,
              backgroundColor: Colors.white,
              borderColor: themeColour4,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WillSelectMemorialScreen(),
                  ),
                );
              },
              boxShadow: [
                BoxShadow(
                  color: themeColour4.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            CommonButtonWidget(
              text: "영상 녹화",
              width: 120,
              height: 120,
              textColor: Colors.black,
              backgroundColor: Colors.white,
              borderColor: themeColour4,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WillSelectMemorialScreen(),
                  ),
                );
              },
              boxShadow: [
                BoxShadow(
                  color: themeColour4.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: Text("이전으로"))
      ]),
    );
  }
}
