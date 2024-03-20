import 'package:flutter/material.dart';
import 'package:frontend/widgets/common_text_widget.dart';

class MypageWillMoreScreen extends StatelessWidget {
  const MypageWillMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: '내가 기록한 유언',
          fontSize: 30,
          isBold: true,
        ),
      ),
    );
  }
}
