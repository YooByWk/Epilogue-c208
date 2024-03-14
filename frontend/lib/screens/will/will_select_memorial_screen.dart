import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_type_screen.dart';
import 'package:frontend/widgets/common_button.dart';

class WillSelectMemorialScreen extends StatelessWidget {
  const WillSelectMemorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: Text('유언장 생성하기'),
      ),
      body: Column(children: [
        Text("디지털 추모관을 이용하시나요?"),
        Column(
          children: [
            CommonButtonWidget(
              text: "이용",
              width: 300,
              height: 80,
              textColor: Colors.black,
              backgroundColor: Colors.white,
              borderColor: themeColour4,
              onPressed: () => (),
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
              onPressed: () => (),
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
                builder: (context) => WillSelectTypeScreen(),
              ),
            );
          },
          child: Text('이전으로'),
        ),
      ]),
    );
  }
}
