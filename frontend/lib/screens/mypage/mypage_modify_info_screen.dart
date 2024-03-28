import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/input_form_widget.dart';
import 'package:provider/provider.dart';

class MypageModifyInfoScreen extends StatelessWidget {
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
        body: Consumer<UserViewModel>(builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.user == null) {
            return Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
          }
          final user = viewModel.user!;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: themeColour3),
                          color: Colors.white),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          CommonText(
                            text: '',
                            fontSize: 24,
                            textColor: themeColour3,
                          ),
                          SizedBox(width: 20),
                          CommonText(
                            text: 'userInfo',
                            textColor: themeColour5,
                            isBold: true,
                            fontSize: 24,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: themeColour3),
                          color: Colors.white),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          CommonText(
                            text: '생년월일',
                            fontSize: 24,
                            textColor: themeColour3,
                          ),
                          SizedBox(width: 15),
                          CommonText(
                            text: 'userInfo',
                            textColor: themeColour5,
                            isBold: true,
                            fontSize: 24,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InputFormWidget(
                            onChanged: (value) => (),
                            keyboardType: TextInputType.number,
                            label: '휴대폰 번호',
                            borderColor: themeColour3,
                            textColor: themeColour3,
                            backgroundColor: Colors.white,
                          ),
                          CommonButtonWidget(
                              text: '인증',
                              width: 60,
                              height: 50,
                              fontSize: 24,
                              backgroundColor: themeColour3,
                              onPressed: () {})
                        ]),
                    SizedBox(height: 20),
                    CommonButtonWidget(
                        text: '수정하기',
                        width: 100,
                        fontSize: 24,
                        onPressed: () {}),
                  ]),
            ),
          );
        }));
  }
}
