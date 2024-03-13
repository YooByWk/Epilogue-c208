import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_viewmodel.dart';

class MemorialScreen extends StatelessWidget {
  const MemorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar : AppBar(
            backgroundColor: themeColour2,
            title : Text('디지털 추모관'), 
          )
          // appBar : 디지털 추모관 텍스트
          
          // body : 이미지
            //
            // 검색

            // 추모관(모비) 리스트 - 백엔드에서 정보 받아서 뿌려줘야 함
             // -> 페이지네이션임 무한스크롤임?

          // 하단바. 아래로 내리면 하단바 사라지게
        );
  } 
}
