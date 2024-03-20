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
    return Column(
      mainAxisSize: MainAxisSize.min, // 컨텐츠에 맞게 크기 조절
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 60,
              height: 60,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
