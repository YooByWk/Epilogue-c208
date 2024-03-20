import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_epitaph_picture_screen.dart';
import 'package:frontend/widgets/common_button.dart';

class WillSelectMemorialScreen extends StatelessWidget {
  const WillSelectMemorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(children: [
        const Text("유언을 안전하게 기록 중입니다 ..."),
        const Text("디지털 추모관을 이용하시나요?"),
        const Text("디지털 추모관은 추후 유언이 공개되었을 때 회원님을 추억할 수 있는 공간입니다."),
        Column(
          children: [
            CommonButtonWidget(
              text: "이용",
              width: 300,
              height: 80,
              textColor: Colors.black,
              backgroundColor: Colors.white,
              borderColor: themeColour4,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WillEpitaphPictureScreen(),
                ),
              ),
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
              text: "이용하지 않음",
              width: 300,
              height: 80,
              textColor: Colors.black,
              backgroundColor: Colors.white,
              borderColor: themeColour4,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WillEpitaphPictureScreen(),
                ),
              ),
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
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('이전'),
        ),
      ]),
    );
  }
}
