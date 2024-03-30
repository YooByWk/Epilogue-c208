import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_input_field_widget.dart';
import 'package:frontend/screens/will/recording_test.dart';
import 'package:frontend/view_models/auth_view_models/login_viewmodel.dart';
import 'package:frontend/screens/login/social_button_widget.dart';
import 'package:frontend/screens/signup/signup_screen.dart';
import 'package:frontend/screens/will/will_select_type_screen.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/memorial_enter_button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Consumer<LoginViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFF617C77),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.13),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          width: 300,
                          height: commonWidth * 0.31,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.5),
                      LoginInputField(
                          label: '아이디',
                          onChanged: (value) => viewModel.setUsername(value)),
                      LoginInputField(
                          label: '비밀번호',
                          padding: 100,
                          obscureText: true,
                          onChanged: (value) => viewModel.setPassword(value)),
                      SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.1),
                            child: InkWell(
                              onTap: () {
                                debugPrint('비밀번호 찾기 버튼 클릭');
                              },
                              child: Text(
                                '비밀번호 찾기',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white60,
                                ),
                              ),
                            )),
                      ]),
                      SizedBox(height: 20),
                      viewModel.isLoading
                          ? CircularProgressIndicator()
                          : Container(),
                      CommonButtonWidget(
                        text: '로그인',
                        textColor: Color(0xFFececec),
                        backgroundColor: viewModel.isLoading
                            ? Colors.grey
                            : Color(0xFFADC2A9),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        fontSize: 30,
                        onPressed: () {
                          if (!viewModel.isLoading) {
                            viewModel.login().then((_) {
                              if (viewModel.errorMessage == null) {
                                Navigator.pushNamed(context, '/home');
                              } else {
                                if (viewModel.errorMessage != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(viewModel.errorMessage!),
                                    ),
                                  );
                                }
                              }
                            });
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        '------------------------------ or ------------------------------',
                        style: TextStyle(fontSize: 20, color: Colors.white60),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialButtonWidget(
                              imagePath: 'assets/images/kakao.png',
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('서비스 준비 중입니다.')),
                                );
                              }),
                          SocialButtonWidget(
                            imagePath: 'assets/images/naver.png',
                            onPressed: () async {
                              await viewModel.loginWithNaver();
                              if (viewModel.isLoginSuccess) {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('로그인 실패')));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            '아이디로 회원가입하기',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WillSelectTypeScreen(),
                            ),
                          );
                        },
                        child: Text('유언 작성'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecordTest(),
                            ),
                          );
                        },
                        child: Text('녹음'),
                      ),
                    ],
                  ),
                ),
                MemorialEnterButton(
                    isFocused: viewModel.isFocused,
                    onTap: () {
                      Navigator.pushNamed(context, '/memorial');
                    })
              ],
            ),
          );
        }));
  }
}
