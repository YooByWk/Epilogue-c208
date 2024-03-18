import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';

class WillViewerScreen extends StatelessWidget {
  const WillViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: Column(children: [
        const Text("디지털 유언장 열람인 지정"),
        Column(
          children: [
            Container(
                height: 130,
                width: 310,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: themeColour3.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Column(
                      children: [
                        // const Text("이름"),
                        TextFormField(
                          // 유효성 검사
                          validator: (String? value) {
                            if (value!.length < 1) {
                              return '필수입력입니다.';
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '이름',
                            hintText: '김싸피',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '번호',
                            hintText: '010-1234-5678',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // const Text("이름"),
                        TextFormField(
                          // 유효성 검사
                          validator: (String? value) {
                            if (value!.length < 1) {
                              return '필수입력입니다.';
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '이메일',
                            hintText: 'ssafy@samsung.com',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '관계',
                            hintText: '가족',
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("이전")),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WillSelectMemorialScreen(),
                ),
              ),
              child: const Text('다음'),
            )
          ],
        ),
      ]),
    );
  }
}
