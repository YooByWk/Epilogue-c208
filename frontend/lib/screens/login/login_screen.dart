import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/login/login_input_field_widget.dart';
import 'package:frontend/screens/login/mnemonic_recovery_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/view_models/auth_view_models/login_viewmodel.dart';
import 'package:frontend/screens/login/social_button_widget.dart';
import 'package:frontend/screens/signup/signup_screen.dart';
import 'package:frontend/screens/will/will_select_type_screen.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/memorial_enter_button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var storage = FlutterSecureStorage();

  _asyncMethod() async {
    String? token = await storage.read(key: 'token');
    debugPrint(token);
    if (token != null) {
      if (!mounted) return;
      // UserViewModel().fetchUserData();
      debugPrint('아마도 자동되야할걸');
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('후');
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
    // _asyncMethod();
  }

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
                      SizedBox(height: 10),
                      LoginInputField(
                          label: '아이디',
                          onChanged: (value) => viewModel.setUsername(value)),
                      SizedBox(
                        height: 30,
                      ),
                      LoginInputField(
                          label: '비밀번호',
                          padding: 100,
                          obscureText: true,
                          onChanged: (value) => viewModel.setPassword(value)),
                      SizedBox(height: 20),
                      // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      //   Padding(
                      //       padding: EdgeInsets.only(
                      //           right: MediaQuery.of(context).size.width * 0.1),
                      //       child: InkWell(
                      //         onTap: () {
                      //           debugPrint('비밀번호 찾기 버튼 클릭');
                      //         },
                      //         child: Text(
                      //           '비밀번호 찾기',
                      //           style: TextStyle(
                      //             fontSize: 18,
                      //             color: Colors.white60,
                      //           ),
                      //         ),
                      //       )),
                      // ]),
                      SizedBox(height: 30),
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
                        onPressed: () async {
                          var _pk = await storage.read(key: 'privateKey');
                          var _userName = await storage.read(key: 'userId');
                          var _owner = await storage.read(key: 'owner');
                          // debugPrint('유저 아이디, 오너 아이디, pk  유저 ${_userName} || 오너 ${_owner}, 피케이 ${ _pk }');

                          if (!viewModel.isLoading) {
                            viewModel.login().then((_) {
                              // 로그인 성공 시 홈 화면으로 이동
                              if (viewModel.errorMessage == null) {
                                // 저장된 키의 주인과 방금 로그인 비교
                                if (_pk != null &&
                                    _owner == viewModel.userName) {
                                  debugPrint('아이디와 오너가 같음');
                                  // 같다면 홈으로 이동
                                  Navigator.pushNamed(context, '/home');
                                } else if (_pk != null &&
                                    _owner != viewModel.userName) {
                                  // 다르다면 로그아웃 혹은 키 복구 요청
                                  debugPrint('아이디와 오너가 다름');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('로그아웃 혹은 유언장 복구'),
                                          content: Text(
                                              '이전에 로그인한 아이디와 현재 로그인한 아이디가 다릅니다. 로그아웃을 하시겠습니까?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  await storage.delete(
                                                      key: 'privateKey');
                                                  await storage.delete(
                                                      key: 'owner');
                                                  Navigator.pushNamed(
                                                      context, '/mnemonic');
                                                  await storage
                                                      .write(
                                                          key: 'owner',
                                                          value: await storage
                                                              .read(
                                                                  key:
                                                                      'userId'))
                                                      .then((value) async =>
                                                          debugPrint(
                                                              '유저이름 저장 : 이 계정 사용 : ${await storage.read(key: 'owner')}'));
                                                },
                                                child: Text('이 계정 사용',
                                                    style: TextStyle(
                                                        color: themeColour5))),
                                            TextButton(
                                                onPressed: () async {
                                                  debugPrint('둘다없음');
                                                  Navigator.pushNamed(
                                                      context, '/login');
                                                  await UserViewModel()
                                                      .logout();
                                                },
                                                child: Text(
                                                  '로그아웃',
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ))
                                          ],
                                        );
                                      });
                                  ();
                                }
                                //
                                else if (_pk == null || _owner == null) {
                                  debugPrint('아이디 혹은 키  없음');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('유언장 복구'),
                                          content: Text(
                                              '저장된 키가 없습니다. \n유언장을 복구하시겠습니까?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  await storage.delete(
                                                      key: 'privateKey');
                                                  await storage.delete(
                                                      key: 'owner');
                                                  await storage
                                                      .write(
                                                          key: 'owner',
                                                          value: await storage
                                                              .read(
                                                                  key:
                                                                      'userId'))
                                                      .then((value) async =>
                                                          debugPrint(
                                                              '유저이름 저장 : 이 계정 사용 : ${await storage.read(key: 'owner')}'));
                                                  Navigator.pushNamed(
                                                      context, '/mnemonic');
                                                },
                                                child: Text('이 계정 사용',
                                                    style: TextStyle(
                                                        color: themeColour5))),
                                            TextButton(
                                                onPressed: () async {
                                                  debugPrint('둘다없음');
                                                  Navigator.pushNamed(
                                                      context, '/login');
                                                  await UserViewModel()
                                                      .logout();
                                                },
                                                child: Text(
                                                  '로그아웃',
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ))
                                          ],
                                        );
                                      });
                                  // 저장된 아이디와 키 모두 없다면 키를 복구한다.
                                  // Navigator.pushNamed(context, '/mnemonic');
                                }
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
                      // Text(
                      //   '------------------------------ or ------------------------------',
                      //   style: TextStyle(fontSize: 20, color: Colors.white60),
                      // ),
                      // SizedBox(height: 15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     SocialButtonWidget(
                      //         imagePath: 'assets/images/kakao.png',
                      //         onPressed: () {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             SnackBar(content: Text('서비스 준비 중입니다.')),
                      //           );
                      //         }),
                      //     SocialButtonWidget(
                      //       imagePath: 'assets/images/naver.png',
                      //       onPressed: () async {
                      //
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => NaverLoginScreen(),
                      //             ),
                      //           );
                      //
                      //       },
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 50),
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
