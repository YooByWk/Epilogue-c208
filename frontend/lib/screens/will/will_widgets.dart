import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class WillEpitaphWidget extends StatelessWidget {
  const WillEpitaphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: 80,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeColour4),
        boxShadow: [
          BoxShadow(
            color: themeColour4.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        style: TextStyle(
          decorationThickness: 0,
          fontSize: 20,
          color: themeColour5,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '묘비명 입력하기',
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
