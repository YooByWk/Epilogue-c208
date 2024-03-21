import 'package:flutter/material.dart';

class LetterTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('LetterTab & 편지탭입니다.');
  }
}


class Letter extends StatelessWidget {
  final String post;
  final int index;

  Letter({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(post),
    );
  }

  
}