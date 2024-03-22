import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_body_screen.dart';

class WillEpitaphWidget extends StatelessWidget {
  const WillEpitaphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.11,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          fontSize: 30,
          color: themeColour5,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '묘비명 입력하기',
          hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
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
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: (checked) ? themeColour5 : Colors.black26,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(
                Icons.check_circle_outline,
                color: (checked) ? themeColour5 : Colors.black26,
                size: 35,
              ),
              SizedBox(width: 10,),
              Text(
                widget.text,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: (checked) ? themeColour5 : Colors.black26,
                  fontFamily: 'Roboto Serif',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
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
  final String? nextText;
  final String? preText;
  final Widget? nextPage;
  final Widget? prePage;

  const TextButtonWidget({
    this.nextText,
    this.preText,
    this.nextPage,
    this.prePage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (preText != null)
                TextButton(
                  onPressed: () {
                    prePage != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => prePage!,
                            ),
                          )
                        : Navigator.pop(context);
                  },
                  child: Text(
                    preText!,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto Serif',
                      color: themeColour5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (nextText != null)
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
                    nextText!,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto Serif',
                      color: themeColour5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}
