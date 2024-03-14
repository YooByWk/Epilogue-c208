import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class MainWilliconWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color textColor;
  final Color borderColor;

  const MainWilliconWidget({
    required this.text,
    required this.imagePath,
    this.textColor = themeColour3,
    this.borderColor = themeColour3,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
        child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
        ),
      );
  }
}