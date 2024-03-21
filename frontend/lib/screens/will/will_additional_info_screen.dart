import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/widgets/custom_bottom_navigation.dart';

class WillAdditionalInfoScreen extends StatefulWidget {
  const WillAdditionalInfoScreen({super.key});
  _WillAdditionalInfoScreenState createState() =>
      _WillAdditionalInfoScreenState();
}

class _WillAdditionalInfoScreenState extends State<WillAdditionalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 30, top: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: "연명치료 여부",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "희망"),
                  ChoiceButtonWidget(text: "미희망")
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextWidget(
                text: "장기기증 여부",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "희망"),
                  ChoiceButtonWidget(text: "미희망")
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextWidget(
                text: "장례방식",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "매장"),
                  ChoiceButtonWidget(text: "화장")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "시신기증"),
                  ChoiceButtonWidget(text: "기타")
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextWidget(
                text: "묘 방식",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "매장"),
                  ChoiceButtonWidget(text: "납골당")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "봉안묘"),
                  ChoiceButtonWidget(text: "평장묘")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceButtonWidget(text: "수목장"),
                  ChoiceButtonWidget(text: "산분")
                ],
              ),
              ChoiceButtonWidget(text: "기타")
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: themeColour3,
        height: 80,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomBottomNavigation(),
              ),
            );
          },
          child: Center(
            child: Text(
              "항목 선택 완료",
              style: TextStyle(color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
