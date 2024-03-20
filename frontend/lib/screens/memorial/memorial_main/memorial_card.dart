import 'package:flutter/material.dart';

class MemorialCard extends StatelessWidget {
  final String imagePath;
  final int index;
  // final String userText;
  final String memorialName;

  MemorialCard({
    required this.imagePath,
    // required this.routes,
    // required this.userText,
    required this.index,
    required this.memorialName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          debugPrint('클릭 인덱스 : $index, $memorialName');
          Navigator.pushNamed(context, '/memorialDetail', arguments: {
            'index': index,
            'memorialName': memorialName,
          });
        },
        child: Image.asset(imagePath),
      ),
    );
  }
}