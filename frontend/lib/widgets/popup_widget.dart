import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final Color textColor;


  const PopupWidget({
    required this.text,
    this.fontSize = 20,
    this.isBold = false,
    this.textColor = Colors.black,

    super.key
});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontWeight: isBold ?  FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
