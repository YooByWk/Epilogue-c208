import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/will/my_will_model.dart';
import 'package:frontend/screens/mypage/mypage_modify_info_screen.dart';
import 'package:frontend/screens/mypage/mypage_will_more_screen.dart';
import 'package:frontend/screens/will/will_select_type_screen.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/my_will_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/will_notice.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/login/login_screen.dart';

class MypageScreen extends StatefulWidget {
  @override
  _MypageScreenState createState() => _MypageScreenState();
}


class _MypageScreenState extends State<MypageScreen> {
  late Future<MyWillModel?> _willInfoFuture;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<UserViewModel>(context, listen: false);
    _willInfoFuture = viewModel.getWillInfo();
  }

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
            // await viewModel.fetchUserData();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(viewModel.errorMessage!)),
                SizedBox(height: 20),
                CommonButtonWidget(text: '홈으로', onPressed: ()=>Navigator.pushNamed(context, '/home').then((value) async => debugPrint('홈으로 이동 후 토큰 ${await storage.read(key: 'token')}')) ),
                SizedBox(height: 20),
                CommonButtonWidget(text: '로그아웃', onPressed: () async {
                  await viewModel.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                }),

              ],
            );
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
                    FutureBuilder(
                      future: _willInfoFuture,
                      builder : (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // 로딩 표시
                } 
                     else {
                      debugPrint(snapshot.data?.graveName.toString());
                      
                  if (snapshot.data == null) {
                    return CommonButtonWidget(
                      height: 200,
                      width: 200,
                      borderColor: themeColour5,
                      text: '생성하기',
                      fontSize: 24,
                      textColor: Colors.black,
                      imagePath: 'assets/images/willmore.png',
                      onPressed: () {
                        showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: WillNotice(),
                                      insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 100,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('동의 후 생성하기'),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size.fromHeight(50),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            backgroundColor: themeColour5,
                                            foregroundColor: Colors.white,
                                            textStyle: TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WillSelectTypeScreen()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                      },
                    );
                  } else {
                    return CommonButtonWidget(
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
                            builder: (context) => MypageWillMoreScreen(path : snapshot.data!.willFileAddress.toString()),
                          ),
                        );
                      },
                    );
                  }
                      }},
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ));
        }));
  }
}
