import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_photo_tab.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_video_tab.dart';


class MemorialDetailTabBar extends StatelessWidget {
  
  final List<Widget> tabs = [
    Tab(text: '사진'),
    Tab(text: '동영상'),
    Tab(text: '편지'),
  ];

  final List<Widget> tabViews = [
    PhotoTab(),
    // Text('동영상탭입니다.'),
    // VideoTabCard(index: index, onFocus: onFocus)
    VideoTab(), // VideoTab 위젯을 구현해야 합니다.
    Text('편지탭입니다.')
    // LetterTab(), // LetterTab 위젯을 구현해야 합니다.
  ];

  MemorialDetailTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController (
      length : tabs.length,
      child : 
      // Expanded(
        // child :
      Column(
        children : [
          TabBar(tabs : tabs),
          Expanded(
            child : TabBarView(children: tabViews)
          )
        ]
      )
    // )
    );

  }
}