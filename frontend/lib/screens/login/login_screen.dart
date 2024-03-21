import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/will/recording_test.dart';
import 'package:frontend/view_models/login_view_models/login_viewmodel.dart';
import 'package:frontend/screens/login/social_button_widget.dart';
import 'package:frontend/screens/signup/signup_screen.dart';
import 'package:frontend/screens/will/will_select_type_screen.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final loginViewModel = Provider.of<LoginViewModel>(context);
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
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              height: commonWidth * 0.31,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.5),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                              left: 0,
                              child: Text(
                                '아이디',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFececec),
                                ),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: Color(0xFFececec),
                                fontSize: 24,
                              ),
                              onChanged: (value) {
                                viewModel.setUserId(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 80),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFececec)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFececec)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                              left: 0,
                              child: Text(
                                '비밀번호',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFececec),
                                ),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFFececec),
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 90),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFececec)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFececec)),
                                ),
                              ),
                              obscureText: true,
                              onChanged: (value) =>
                                  viewModel.setPassword(value),
                            ),
                          ],
                        ),
                      ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: CommonButtonWidget(
                          text: '로그인',
                          textColor: Color(0xFFececec),
                          backgroundColor: Color(0xFFADC2A9),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          fontSize: 30,
                          onPressed: () {
                            viewModel.login();
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
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
                            onPressed: () =>
                                debugPrint('Kakao login button clicked!'),
                          ),
                          SocialButtonWidget(
                            imagePath: 'assets/images/naver.png',
                            onPressed: () =>
                                debugPrint('Naver login button clicked!'),
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
                Positioned(
                    height: MediaQuery.of(context).size.height * 0.1,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: !viewModel.isFocused
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/memorial');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFC0BC9C),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        // height: MediaQuery.of(context).size.height * 0.1,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/flower.png'),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                      ),
                                      Text('디지털 추모관 입장 >',
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Color(0xFF121212),
                                          ))
                                    ]),
                              ),
                            ))
                        : Container()),
              ],
            ),
          );
        }));
  }
}
