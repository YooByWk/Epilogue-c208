import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';

class MemorialDetailScreen extends StatelessWidget {


  const MemorialDetailScreen(
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> arguments = 
    // ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // int index = arguments['index'];
    // String userName = arguments['userName'];



    return  Scaffold(
      appBar: MemorialAppBar(
        // screenName: '故 $userName 님의 추모관',
        screenName: '추모관상세',
      ),
      // body: Text('$index 번 추모관입니다.')
      body: Text('추모관 상세 페이지입니다.')
    );
  }




}