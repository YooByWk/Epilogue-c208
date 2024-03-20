import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_screen.dart';

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
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const TextWidget({
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto Serif',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class ChoiceButtonWidget extends StatefulWidget {
  _ChoiceButtonWidgetState createState() => _ChoiceButtonWidgetState();

  final String text;

  const ChoiceButtonWidget({required this.text});
}

class _ChoiceButtonWidgetState extends State<ChoiceButtonWidget> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;
        });
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: (checked) ? themeColour3 : Colors.grey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: (checked) ? themeColour3 : Colors.grey.withOpacity(0.5),
            ),
            Text(
              widget.text,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: (checked) ? themeColour3 : Colors.grey.withOpacity(0.5),
                fontFamily: 'Roboto Serif',
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WillCommonButtonWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final VoidCallback onPressed;

  const WillCommonButtonWidget({
    required this.text,
    this.backgroundColor = Colors.white,
    required this.onPressed,
    this.width = 150.0,
    this.height = 35.0,
    this.fontSize = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: themeColour3),
            boxShadow: [
              BoxShadow(
                color: themeColour4.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String nextText;
  final String preText;
  final Widget? nextPage;
  final Widget? prePage;

  const TextButtonWidget({
    this.nextText = '다음',
    this.preText = '이전',
    this.nextPage,
    this.prePage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          TextButton(onPressed: ()

        {
          prePage != null ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => prePage!,
            ),
          ) : Navigator.pop(context);
        }, child: Text(preText, style: TextStyle(fontSize: 23, fontFamily: 'Roboto Serif', color: themeColour4,),),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => nextPage!,
              ),
            );
          },
          child: Text(
            nextText,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Roboto Serif',
              color: themeColour4,
            ),
          ),
        ),
      ],
    );
  }
}
