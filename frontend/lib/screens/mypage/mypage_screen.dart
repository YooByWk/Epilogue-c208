import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/mypage/mypage_modify_info_screen.dart';
import 'package:frontend/screens/mypage/mypage_will_more_screen.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/pin_memorial_widget.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: '내 공간',
          isBold: true,
          fontSize: 40,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonText(
                    text: 'username 님',
                    fontSize: 30,
                    isBold: true,
                  ),
                  CommonButtonWidget(
                      text: '정보 수정',
                      width: 100,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MypageModifyInfoScreen()));
                      }),
                  CommonButtonWidget(
                      text: '로그아웃',
                      width: 100,
                      backgroundColor: themeColour3,
                      onPressed: () {}),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    CommonText(
                      text: '내가 기록한 유언',
                      fontSize: 24,
                      isBold: true,
                    ),
                    SizedBox(height: 20),
                    CommonButtonWidget(
                        height: 200,
                        width: 200,
                        borderColor: themeColour5,
                        text: '더보기',
                        fontSize: 24,
                        textColor: Colors.black,
                        imagePath: 'assets/images/willmore.png',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MypageWillMoreScreen()));
                        }),
                    SizedBox(height: 40),
                    CommonText(
                      text: '즐겨찾기 한 추모관',
                      fontSize: 24,
                      isBold: true,
                    ),
                    SizedBox(height: 20),
                    PinMemorialWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
