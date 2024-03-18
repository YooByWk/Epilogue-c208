import 'package:flutter/material.dart';
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '아이디',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFececec),
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                viewModel.setUserId(value);
                              },
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFececec),
                              ),
                              decoration: InputDecoration(
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFececec),
                          ),
                          decoration: InputDecoration(
                            labelText: '비밀번호',
                            labelStyle: TextStyle(
                              color: Color(0xFFececec),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFececec)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFececec)),
                            ),
                          ),
                          obscureText: true,
                          onChanged: (value) => viewModel.setPassword(value),
                        ),
                      ),
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
                                  fontSize: 15,
                                  color: Colors.white60,
                                ),
                              ),
                            )),
                      ]),
                      SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: CommonButtonWidget(
                          text: '로그인',
                          textColor: Color(0xFFececec),
                          backgroundColor: Color(0xFFADC2A9),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          fontSize: 23,
                          onPressed: () {
                            viewModel.login();
                            Navigator.pushNamed(context, '/main');
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '------------------or------------------',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      SizedBox(height: 7),
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
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Text('다음 페이지'),
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
