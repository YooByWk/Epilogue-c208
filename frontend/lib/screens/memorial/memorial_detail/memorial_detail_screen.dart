import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_tabBar.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_profile.dart';

class MemorialDetailScreen extends StatelessWidget {
  const MemorialDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final index = args?['index'] ?? '인덱스';
    final memorialName = args?['memorialName'] ?? '유저이름';

    debugPrint(ModalRoute.of(context)!.settings.arguments.toString() +
        '추모관 상세 페이지입니다.');

    return Scaffold(
        appBar: MemorialAppBar(
          screenName: '故 $memorialName 님의 추모관',
          isMenu: true,
          items: ['회원가입', '로그인', '로그아웃'],
          onSelected: (value) {
            debugPrint('$value 선택됨');
          },
          // screenName: '추모관상세',
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget> [
              SliverList(
                delegate: SliverChildListDelegate([
                                Container(
                  // height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(),
                  child: MemorialProfile(
                    memorialName: memorialName,
                    index: index,
                  )),
                ])
              )
            ];
          },
          body: MemorialDetailTabBar(),
          ),
        ); 
  }
}
        
//          CustomScrollView(slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate([
//               // Container(
//               //     // height: MediaQuery.of(context).size.height * 0.1,
//               //     decoration: BoxDecoration(),
//               //     child: MemorialProfile(
//               //       memorialName: memorialName,
//               //       index: index,
//               //     )),
//             ]),
//           ),
//           // SliverFillRemaining(child: MemorialDetailTabBar())
          
//         ]));
//   }
// }
