import 'package:flutter/material.dart';

class MemorialCard extends StatelessWidget {
  final String imagePath;
  final int index;
  // final String userText;
  final String userName;

  MemorialCard({
    required this.imagePath,
    // required this.routes,
    // required this.userText,
    required this.index,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          debugPrint('클릭 인덱스 : $index, $userName');
          Navigator.pushNamed(context, '/memorialDetail', arguments: {
            'index': index,
            'userName': userName,
          });
        },
        child: Image.asset(imagePath),
      ),
    );
  }
}