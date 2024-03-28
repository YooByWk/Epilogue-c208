import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/view_models/will_view_models/viewer_viewmodel.dart';
import 'package:frontend/widgets/popup_widget.dart';
import 'package:frontend/widgets/will_viewer_widget.dart';
import 'package:provider/provider.dart';

class WillViewerScreen extends StatefulWidget {
  _WillViewerScreenState createState() => _WillViewerScreenState();
}

class _WillViewerScreenState extends State<WillViewerScreen> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewerViewModel(),
      child: Consumer<ViewerViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColour2,
              title: const Text('유언장 생성하기'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                  child: TextWidget(
                    text: "디지털 유언장 \n열람인 지정",
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      '최대 5인 지정 가능',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: min(5, viewModel.viewerList.length + 1),
                    itemBuilder: (context, index) {
                      if (viewModel.viewerList.length > index) {
                        // 기존 열람인 정보 출력
                        final item = viewModel.viewerList[index];
                        return Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: themeColour3.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                item.viewerName,
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                item.viewerMobile!,
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                item.viewerEmail!,
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  viewModel.deleteViewer(index).then((_) {
                                    debugPrint('삭제 완료');
                                  });
                                },
                                child: Text(
                                  '삭제',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeColour5),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index == 5) {
                        return Text("열람인은 최대 5인까지 지정 가능합니다.");
                      } else {
                        return Column(
                          children: [
                            WillViewerWidget(
                              viewModel: viewModel,
                            ),
                            TextButton(
                              child: Text(
                                '저장',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeColour5),
                              ),
                              onPressed: () {
                                debugPrint(viewModel.viewerName);
                                (viewModel.viewerName == '')
                                    ? PopupWidget(
                                        text: '열람인 이름을 입력해 주세요!',
                                        buttonText1: '확인',
                                        onConfirm1: () {
                                          Navigator.pop(context);
                                        })
                                    : (viewModel.viewerMobile == '' &&
                                            viewModel.viewerEmail == '')
                                        ? PopupWidget(
                                    text: '열람인의 번호 혹은 이메일을 입력해 주세요!',
                                    buttonText1: '확인',
                                    onConfirm1: () {
                                      Navigator.pop(context);
                                    })
                                        : viewModel.addViewer().then((_) {
                                            debugPrint('저장 완료');
                                          });
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            bottomNavigationBar: SizedBox(
              width: double.infinity,
              height: 100,
              child: TextButtonWidget(
                preText: '이전',
                nextText: '다음',
                onPressed: () {
                  if (!viewModel.isLoading) {
                    viewModel.setViewer().then((_) {
                      if (viewModel.errorMessage == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WillSelectMemorialScreen(),
                          ),
                        );
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
            ),
          );
        },
      ),
    );
  }
}
