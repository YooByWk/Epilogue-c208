import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets//input_form_widget.dart';
import 'package:frontend/view_models/signup_view_models/signup_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<SignupViewModel>(context, listen: false);

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
                      keyboardType: TextInputType.text,
                      onChanged: (value) => viewModel.setName(value)),
                  SizedBox(height: 10),
                  InputFormWidget(
                      label: '생년월일',
                      textColor: Colors.white,
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
                            onPressed: () {})
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
                              contentPadding: EdgeInsets.only(bottom: 5, left: 90),
                              onChanged: (value) => viewModel.setUserId(value)),
                        ),
                        SizedBox(width: 10),
                        CommonButtonWidget(
                            text: '중복\n확인',
                            width: 60,
                            height: 50,
                            fontSize: 20,
                            backgroundColor: themeColour3,
                            onPressed: () {})
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  InputFormWidget(
                      label: '비밀번호',
                      textColor: Colors.white,
                      keyboardType: TextInputType.text,
                      onChanged: (value) => viewModel.setPassword(value),
                      obscureText: true),
                  SizedBox(height: 10),
                  InputFormWidget(
                      label: '비밀번호 확인',
                      textColor: Colors.white,
                      contentPadding: EdgeInsets.only(bottom: 5, left: 140),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => viewModel.setConfirmPassword(value),
                      obscureText: true),
                  SizedBox(height: 20),
                  CommonButtonWidget(
                      text: '회원가입',
                      fontSize: 30,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      backgroundColor: themeColour3,
                      onPressed: () async {
                        await viewModel.signup();
                        if (viewModel.errorMessage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('회원가입 성공')),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text(viewModel.errorMessage!)),
                          );
                        }
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
