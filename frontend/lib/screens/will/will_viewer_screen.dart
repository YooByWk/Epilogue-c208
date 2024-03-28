import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_check_screen.dart';
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
        child: Consumer<ViewerViewModel>(builder: (context, viewModel, child) {
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
                  Column(
                    children: List.generate(counter, (index) {
                      bool isSaved = index != counter - 1;
                      return Column(
                        children: [
                          WillViewerWidget(viewModel: viewModel, isSaved: isSaved),
                          Container(
                              child: (index > 0)
                                  ? ElevatedButton(
                                      onPressed: () => delete(index),
                                      child: Text('삭제'))
                                  : null),
                        ],
                      );
                    }),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: (counter < 5)
                          ? ElevatedButton(
                              onPressed: () {
                                viewModel.addViewer().then((_) {
                                  debugPrint('성공');
                                  increment();
                                });
                              },
                              child: Text('저장'))
                          : null),
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
        }));
  }

  void increment() {
    setState(() {
      if (counter < 5) {
        counter++;
      }
    });
  }

  void delete(int index) {
    setState(() {
      if (counter > 1) {
        counter--;
        if (index > 0) {
          (context as Element).markNeedsBuild();
        }
      }
    });
  }
}
