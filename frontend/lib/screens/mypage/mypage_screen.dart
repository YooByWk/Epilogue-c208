import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/mypage/mypage_modify_info_screen.dart';
import 'package:frontend/screens/mypage/mypage_will_more_screen.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: '내 공간',
          isBold: true,
          fontSize: 30,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonText(
                    text: 'username 님',
                    fontSize: 24,
                    isBold: true,
                  ),
                  CommonButtonWidget(
                      text: '정보 수정',
                      width: 100,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MypageModifyInfoScreen()));
                      }),
                  CommonButtonWidget(
                      text: '로그아웃',
                      width: 100,
                      backgroundColor: themeColour3,
                      onPressed: () {}),
                ],
              ),
              SizedBox(height: 30),
              CommonText(
                text: '내가 기록한 유언',
                fontSize: 20,
                isBold: true,
              ),
              CommonButtonWidget(
                  height: 150,
                  width: 150,
                  borderColor: themeColour5,
                  text: '더보기',
                  fontSize: 20,
                  textColor: Colors.black,
                  imagePath: 'assets/images/willmore.png',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MypageWillMoreScreen()));
                  }),
              SizedBox(height: 30),
              CommonText(
                text: '즐겨찾기 한 추모관',
                fontSize: 20,
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
