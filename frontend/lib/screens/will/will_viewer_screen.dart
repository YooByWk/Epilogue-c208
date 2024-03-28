import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/view_models/will_view_models/viewer_viewmodel.dart';
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
            body: SingleChildScrollView(
              child: Column(
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
                  // Column(
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: min(5, viewModel.viewerList.length + 1),
                        itemBuilder: (context, index) {
                          if (viewModel.viewerList.length > index) {
                            // 기존 열람인 정보 출력
                            final item = viewModel.viewerList[index];
                            return Row(
                              children: [
                                Text(item.viewerName),
                                Text(item.viewerMobile!),
                                Text(item.viewerEmail!),
                                TextButton(
                                  onPressed: () {
                                    viewModel.deleteViewer(index).then((_) {
                                      debugPrint('삭제 완료');
                                    });
                                  },
                                  child: Text('삭제'),
                                ),
                              ],
                            );
                          } else if (index == 5) {
                            return Text("열람인은 최대 5인까지ㄴㅇ 지정 가능합니다.");
                          } else {
                            return Row(
                              children: [
                                WillViewerWidget(
                                  viewModel: viewModel,
                                  isSaved: viewModel.viewerList.length > index,
                                ),
                                TextButton(
                                  child: Text('저장'),
                                  onPressed: () {
                                    viewModel.addViewer().then((_) {
                                      debugPrint('저장 완료');
                                    });
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ))
                ],
              ),
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
