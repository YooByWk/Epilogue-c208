import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_info_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/widgets/common_button.dart';

class WillEpitaphPictureScreen extends StatefulWidget {
  _WillEpitaphPictureScreenState createState() =>
      _WillEpitaphPictureScreenState();
}

class _WillEpitaphPictureScreenState extends State<WillEpitaphPictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(children: [
        const Text("추모관에 등록할 \n 묘비명과 사진"),
        Column(
          children: [
            WillEpitaphWidget(),
            CommonButtonWidget(
              text: "사진 업로드",
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
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('이전'),
        ),
        TextButton(
          onPressed: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WillSelectInfoScreen(),
                ),
              ),
          child: const Text('다음'),
        ),
      ]),
    );
  }
}