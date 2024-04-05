import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/screens/will/will_witness_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';

class WillSelectTypeScreen extends StatefulWidget {
  _WillSelectTypeScreenState createState() => _WillSelectTypeScreenState();
}

class _WillSelectTypeScreenState extends State<WillSelectTypeScreen> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                              text: "유언",
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                            TextWidget(
                              text: "을",
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        TextWidget(
                          text: "남기고 싶은 방법",
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WillCommonButtonWidget(
                  text: "음성 녹음",
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillWitnessScreen(),
                    ),
                  ),
                ),
                WillCommonButtonWidget(
                    text: "영상 녹화",
                    fontColor: Colors.grey,
                    backgroundColor: Colors.grey[400],
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.2,
                    onPressed: () => {}),
              ],
            ),
          ]),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        child: TextButtonWidget(
          preText: '이전',
          prePage: MainScreen(),
        ),
      ),
    );
  }
}
