import 'package:flutter/material.dart';

class MainDescriptionWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const MainDescriptionWidget({
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
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
