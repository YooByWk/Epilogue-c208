import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_letter_tab.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_photo_tab.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_video_tab.dart';

class MemorialDetailTabBar extends StatelessWidget {
  
  final List<Widget> tabs = [
    Tab(child :Column(children : [Text('사진'), Icon(Icons.photo)])),
    Tab(child :Column(children : [Text('동영상'), Icon(Icons.video_library_rounded)])),
    Tab(child :Column(children : [Text('편지'), Icon(Icons.local_post_office_rounded)])),
  ];

  final List<Widget> tabViews = [
    PhotoTab(),
    // Text('동영상탭입니다.'),
    // VideoTabCard(index: index, onFocus: onFocus)
    VideoTab(), // VideoTab 위젯을 구현해야 합니다.
    // Text('편지탭입니다.')
    LetterTab(), // LetterTab 위젯을 구현해야 합니다.
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
          TabBar(tabs : tabs,
          labelColor: themeColour5,
          labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 4),
          enableFeedback: true,
          indicatorColor : themeColour5,
          ),
          Expanded(
            child : TabBarView(children: tabViews)
          )
        ]
      )
    // )
    );

  }
}