import 'package:flutter/cupertino.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: "추모관에 등록할",
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: '묘비명',
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                    TextWidget(
                      text: '과',
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                    ),
                    TextWidget(
                      text: '사진',
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: WillEpitaphWidget(),
          ),
          Center(
            child: WillCommonButtonWidget(
              text: "사진 업로드",
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.11,
              backgroundColor: Colors.white,
              onPressed: () => (),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('이전'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WillSelectInfoScreen(),
              ),
            ),
            child: const Text('다음'),
          ),
        ],
      ),
    );
  }
}
