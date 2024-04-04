import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_widgets.dart';

class MemorialBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: MemorialText(
                    text: '삼가 고인의 명복을 빕니다.',
                    size: 30,
                    isBold: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MemorialText(
                          text: '사랑하는 사람들과의 아름다운 추억을 간직할 수 있는',
                          size: 17,
                          align: 'end',
                        ),
                        MemorialText(
                          text: '에필로그의 디지털 추모관입니다.',
                          size: 17,
                          align: 'end',
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            MemorialText(
                              text: '잠시나마 과거로 돌아가 행복했던 시간',
                              size: 15,
                              align: 'end',
                            ),
                            MemorialText(
                              text: '추억하셨으면 좋겠습니다.',
                              size: 15,
                              align: 'end',
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}