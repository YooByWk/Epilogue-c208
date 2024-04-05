import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_additional_info_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/screens/main/main_screen.dart';

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
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
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
                                text: "추가 정보",
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                              ),
                              TextWidget(
                                text: "를",
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          TextWidget(
                            text: "입력하시겠어요?",
                            fontSize: 50,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextWidget(
                              text:
                                  "[추가 정보] \n 연명치료 여부, 장기기증 여부, \n 장례 방식, 묘 방식",
                              fontSize: 23),
                        ],
                      ),
                    ]),
              ),
              Center(
                child: WillCommonButtonWidget(
                  text: "입력하기",
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.11,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillAdditionalInfoScreen(),
                    ),
                  ),
                ),
              ),
              Center(
                child: WillCommonButtonWidget(
                  text: "메인으로",
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.11,
                  backgroundColor: themeColour3.withOpacity(0.5),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 100,
          child: TextButtonWidget(
            preText: '이전',
          ),
        ));
  }
}
