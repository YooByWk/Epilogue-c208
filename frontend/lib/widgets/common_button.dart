import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final String text;
  final String? imagePath;
  final Color textColor;
  final Color backgroundColor;
  final double width;
  final double height;
  final double fontSize;
  final Border? border;
  final VoidCallback onPressed;

  const CommonButtonWidget({
    required this.text,
    this.imagePath,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
    this.width = 150.0,
    this.height = 35.0,
    this.fontSize = 16.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: imagePath == null ? backgroundColor : null,
            borderRadius: BorderRadius.circular(8.0),
            border: border,
            image: imagePath != null
                ? DecorationImage(
              image: AssetImage(imagePath!),
              fit: BoxFit.cover,
            ) : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          )
      ),
    );
  }
}