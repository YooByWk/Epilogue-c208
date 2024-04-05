import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets//input_form_widget.dart';
import 'package:frontend/view_models/auth_view_models/signup_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupViewModel(),
      child: Consumer<SignupViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Color(0xFF617C77),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  InputFormWidget(
                      label: '이름',
                      textColor: Colors.white,
                      hintText: '예시)   홍길동',
                      hintTextStyle:
                          TextStyle(fontSize: 20, color: Colors.grey[400]),
                      keyboardType: TextInputType.text,
                      onChanged: (value) => viewModel.setName(value)),
                  SizedBox(height: 10),
                  InputFormWidget(
                      label: '생년월일',
                      textColor: Colors.white,
                      hintText: '예시) 1995.03.08',
                      hintTextStyle:
                          TextStyle(fontSize: 20, color: Colors.grey[400]),
                      contentPadding: EdgeInsets.only(bottom: 5, left: 100),
                      onChanged: (value) => viewModel.setBirth(value)),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InputFormWidget(
                            label: '휴대폰 번호',
                            textColor: Colors.white,
                            hintText: '예시) 01012345678',
                            hintTextStyle: TextStyle(
                                fontSize: 18, color: Colors.grey[400]),
                            contentPadding:
                                EdgeInsets.only(bottom: 5, left: 130),
                            onChanged: (value) => viewModel.setMobile(value),
                          ),
                        ),
                        SizedBox(width: 10),
                        CommonButtonWidget(
                            text: '인증',
                            width: 60,
                            height: 50,
                            fontSize: 24,
                            backgroundColor: themeColour3,
                            onPressed: () async {
                              await viewModel.mobileCertificationSend();
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InputFormWidget(
                            label: '인증번호',
                            textColor: Colors.white,
                            hintText: '인증번호를 입력해주세요',
                            hintTextStyle: TextStyle(
                                fontSize: 16, color: Colors.grey[400]),
                            keyboardType: TextInputType.text,
                            onChanged: (value) =>
                                viewModel.setCertificationNumber(value),
                          ),
                        ),
                        SizedBox(width: 10),
                        CommonButtonWidget(
                            text: '확인',
                            width: 60,
                            height: 50,
                            fontSize: 20,
                            backgroundColor: themeColour3,
                            onPressed: () async {
                              bool result = await viewModel.verifyCode();
                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('인증에 성공했습니다.')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('인증번호를 확인해주세요.')));
                              }
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InputFormWidget(
                              label: '아이디',
                              textColor: Colors.white,
                              keyboardType: TextInputType.text,
                              contentPadding:
                                  EdgeInsets.only(bottom: 5, left: 90),
                              onChanged: (value) => viewModel.setUserId(value)),
                        ),
                        SizedBox(width: 10),
                        CommonButtonWidget(
                            text: '중복\n여부',
                            width: 60,
                            height: 50,
                            fontSize: 20,
                            backgroundColor: themeColour3,
                            onPressed: () async {
                              await viewModel.checkUserId();
                              if (viewModel.userIdExists == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('사용 가능한 아이디입니다.'),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(viewModel.userIdExists!),
                                ));
                              }
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  InputFormWidget(
                      label: '비밀번호',
                      textColor: Colors.white,
                      hintText: '8~16자 영어 대/소문자,숫자,특수문자 조합',
                      hintTextStyle:
                          TextStyle(fontSize: 16, color: Colors.grey[400]),
                      keyboardType: TextInputType.text,
                      onChanged: (value) => viewModel.setPassword(value),
                      obscureText: true),
                  SizedBox(height: 10),
                  InputFormWidget(
                      label: '비밀번호 확인',
                      textColor: Colors.white,
                      hintText: '비밀번호를 한 번 더 입력해주세요',
                      hintTextStyle:
                          TextStyle(fontSize: 16, color: Colors.grey[400]),
                      contentPadding: EdgeInsets.only(bottom: 5, left: 140),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => viewModel.setConfirmPassword(value),
                      obscureText: true),
                  if (!viewModel.isPasswordSame)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '비밀번호가 일치하지 않습니다.',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  SizedBox(height: 20),
                  CommonButtonWidget(
                      text: '회원가입',
                      fontSize: 30,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      backgroundColor: themeColour3,
                      onPressed: () async {
                              // 지울것
                              await viewModel.signup();
                                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('회원가입 성공')),
                              // 지울것
                            );
                            await storage.write(key : 'owner', value : viewModel.userId);
                            debugPrint('owner : ${await storage.read(key : 'owner')}');

                            Navigator.pushNamed(context, '/myMnemonic').then((_) => {})     ; 
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
