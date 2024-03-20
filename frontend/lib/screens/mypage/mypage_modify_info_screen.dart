import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/input_form_widget.dart';

class MypageModifyInfoScreen extends StatefulWidget {
  const MypageModifyInfoScreen({super.key});

  @override
  State<MypageModifyInfoScreen> createState() => _MypageModifyInfoScreenState();
}

class _MypageModifyInfoScreenState extends State<MypageModifyInfoScreen> {
  TextEditingController _phonenumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: '정보 수정',
          isBold: true,
          fontSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: themeColour3),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이름 ',
                style: TextStyle(
                  fontSize: 16,
                  color: themeColour3,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: themeColour3),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '생년월일 ',
                style: TextStyle(
                  fontSize: 16,
                  color: themeColour3,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          InputFormWidget(
            controller: _phonenumController,
            keyboardType: TextInputType.number,
            label: '휴대폰 번호',
            borderColor: themeColour3,
            textColor: Colors.black,
            width: MediaQuery.of(context).size.width * 0.8,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 10),
          CommonButtonWidget(text: '수정하기', onPressed: () {})
        ]),
      ),
    );
  }
}
