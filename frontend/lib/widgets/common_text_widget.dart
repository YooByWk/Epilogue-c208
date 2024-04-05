import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class CommonText extends StatelessWidget {
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;

  final String text;
  final double fontSize;
  final Color textColor;

  Color getColour(String colour) {
    switch (colour) {
      case 'themeColour1':
        return themeColour1;
      case 'themeColour2':
        return themeColour2;
      case 'themeColour3':
        return themeColour3;
      case 'themeColour4':
        return themeColour4;
      case 'themeColour5':
        return themeColour5;
      case 'whiteText':
        return whiteText;
      case 'blackText':
        return blackText;
      default:
        return themeColour2;
    }
  }

  const CommonText({
    required this.text,
    this.isBold = false,
    this.isItalic = false,
    this.isUnderline = false,
    this.fontSize = 16,
    this.textColor = blackText,
    
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style : TextStyle (
        color: textColor,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      )
    );
  }
}
