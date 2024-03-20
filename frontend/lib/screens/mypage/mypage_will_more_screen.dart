import 'package:flutter/material.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/popup_widget.dart';
import 'package:frontend/widgets/will_additional_info_widget.dart';
import 'package:frontend/main.dart';

class MypageWillMoreScreen extends StatelessWidget {
  const MypageWillMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: '내가 기록한 유언',
          fontSize: 30,
          isBold: true,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CommonButtonWidget(
              text: '삭제',
              width: 80,
              fontSize: 20,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      content: PopupWidget(
                          text: '삭제하면 처음부터 다시 생성해야 합니다.\n 정말 삭제하시겠습니까?'),
                      insetPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 100,
                      ),
                      actions: [
                        ElevatedButton(
                          child: const Text('삭제'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)
                                )
                            ),
                            backgroundColor: themeColour5,
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CommonButtonWidget(
                    height: 300,
                    width: 300,
                    text: '묘비명\n故김싸피',
                    fontSize: 24,
                    textColor: Colors.black,
                    imagePath: 'assets/images/stone.png',
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 25,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              WillAdditionalInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
