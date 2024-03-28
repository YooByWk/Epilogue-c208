import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

import 'package:frontend/screens/mypage/mypage_modify_info_screen.dart';
import 'package:frontend/screens/mypage/mypage_will_more_screen.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/pin_memorial_widget.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/login/login_screen.dart';

class MypageScreen extends StatelessWidget {
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
        body: Consumer<UserViewModel>(builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.user == null) {
            return Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
          }
          final user = viewModel.user!;
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonText(
                    text: '${user.name}님',
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
                                builder: (context) => Provider<UserViewModel>(
                                      create: (context) => UserViewModel(),
                                      child: MypageModifyInfoScreen(),
                                    )));
                      }),
                  CommonButtonWidget(
                      text: '로그아웃',
                      width: 100,
                      backgroundColor: themeColour3,
                      onPressed: () async {
                        await viewModel.logout();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                      }),
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
          ));
        }));
  }
}
