import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class WillViewerWidget extends StatefulWidget {
  _WillViewerWidgetState createState() => _WillViewerWidgetState();
}

class _WillViewerWidgetState extends State<WillViewerWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                            borderSide: BorderSide(color: Color(0xFFececec)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFececec)),
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
                            borderSide: BorderSide(color: Color(0xFFececec)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFececec)),
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
                            borderSide: BorderSide(color: Color(0xFFececec)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFececec)),
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
                            borderSide: BorderSide(color: Color(0xFFececec)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFececec)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
