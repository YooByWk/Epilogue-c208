import 'package:flutter/material.dart';
import 'package:frontend/widgets/common_text_widget.dart';

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
      body: Column(children: [
        TextField(
          decoration: InputDecoration(
            labelText: '이름',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: '생년월일',
          ),
        ),
        TextField(
          controller: _phonenumController,
          decoration: InputDecoration(
            labelText: '휴대폰 번호',
          ),
        ),
      ]),
    );
  }
}
