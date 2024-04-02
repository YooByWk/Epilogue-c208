import 'package:frontend/screens/mypage/mypage_play.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view_models/will_view_models/will_open_viewmodel.dart';
import 'package:provider/provider.dart';

class WillOpenViewerScreen extends StatefulWidget {
  WillOpenViewerScreen({
    Key? key}) : super(key: key);

  @override
  _WillOpenViewerScreenState createState() => _WillOpenViewerScreenState();
}

class _WillOpenViewerScreenState extends State<WillOpenViewerScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => WillOpenViewModel(),
        child: Consumer<WillOpenViewModel>(
          builder: (context, viewModel, _) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    '유언장 확인하기',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                body: SingleChildScrollView(
                  // 여기에 SingleChildScrollView 추가
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '유언장을 확인하기 위해\n전달 받은 코드를 입력해주세요.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,
                            child: TextField(
                              controller: _codeController,
                              decoration: InputDecoration(
                                labelText: '보안코드',
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(100, 50),
                              backgroundColor: Color(0xFF617C77),
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_codeController.text.isNotEmpty) {
                                FocusScope.of(context).unfocus(); // 키보드 숨기기
                                await viewModel
                                    .submitCode(_codeController.text);
                                setState(() {

                                });
                              }
                            },
                            child: Text('제출하기'),
                          ),
                          SizedBox(height: 30),
                          viewModel.s3url != null
                              ? MyPagePlay(path: viewModel.s3url!)
                              : SizedBox(height: 35, child: Center(child: Text(
                              "오디오 파일을 로드하는 중입니다."))),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
