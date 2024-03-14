import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';

class MemorialDetailScreen extends StatelessWidget {


  const MemorialDetailScreen(
    {super.key}
  );
  @override
  Widget build(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  final index = args?['index'] ?? '인덱스';
  final userName = args?['userName'] ?? '유저이름';

  debugPrint(ModalRoute.of(context)!.settings.arguments.toString() + '추모관 상세 페이지입니다.');

    return  Scaffold(
      appBar: MemorialAppBar(
        screenName: '故 $userName 님의 추모관',
        // screenName: '추모관상세',
      ),
      body: Text('$index 번 추모관입니다.')
      // body: Text('추모관 상세 페이지입니다.')
    );
  }



}