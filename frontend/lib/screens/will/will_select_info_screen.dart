import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/will/will_additional_info_screen.dart';
import 'package:frontend/widgets/common_button.dart';

class WillSelectInfoScreen extends StatefulWidget {
  _WillSelectInfoScreenState createState() => _WillSelectInfoScreenState();
}

class _WillSelectInfoScreenState extends State<WillSelectInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(
        children: [
          const Text("추가 정보를 \n 입력하시겠어요?"),
          const Text("[추가 정보] \n 연명치료 여부, 장기기증 여부, \n 장례 방식, 묘 방식"),
          Column(
            children: [
              CommonButtonWidget(
                text: "입력하기",
                width: 300,
                height: 80,
                textColor: Colors.black,
                backgroundColor: Colors.white,
                borderColor: themeColour4,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WillAdditionalInfoScreen(),
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
                text: "메인으로",
                width: 300,
                height: 80,
                textColor: Colors.black,
                backgroundColor: themeColour3.withOpacity(0.5),
                borderColor: themeColour4,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
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
        ],
      ),
    );
  }
}
