import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_memorial_screen.dart';

class WillViewerScreen extends StatefulWidget {
  _WillViewerScreenState createState() => _WillViewerScreenState();
}

class _WillViewerScreenState extends State<WillViewerScreen> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("디지털 유언장 열람인 지정"),
            const Text("최대 5인 지정"),

            Column(
              children: List.generate(counter, (index) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeColour3.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '이름',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: themeColour4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                                decoration: InputDecoration(
                                  hintText: '이싸피',
                                  hintStyle: TextStyle(color: themeColour5),
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
                              Text(
                                '번호',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: themeColour4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                                decoration: InputDecoration(
                                  hintText: '010-1234-5678',
                                  hintStyle: TextStyle(color: themeColour5),
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
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '이메일',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: themeColour4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'ssafy@samsung.com',
                                  hintStyle: TextStyle(color: themeColour5),
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
                              Text(
                                '관계',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: themeColour4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(
                                  decorationThickness: 0,
                                  fontSize: 20,
                                  color: themeColour5,
                                ),
                                decoration: InputDecoration(
                                  hintText: '가족',
                                  hintStyle: TextStyle(color: themeColour5),
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
                      ),
                    ],
                  ),
                );
              }),
            ),
            ElevatedButton(onPressed: increment, child: Text('추가')),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("이전"),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WillSelectMemorialScreen(),
                    ),
                  ),
                  child: const Text('다음'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void increment() {
    setState(() {
      if (counter < 5) {
        counter++;
      }
    });
  }
}
