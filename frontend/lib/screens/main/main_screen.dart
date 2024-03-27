import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_body_screen.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/screens/mypage/mypage_screen.dart';
import 'package:frontend/view_models/main_view_models/main_viewmodel.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final MainViewModel viewModel = Provider.of<MainViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
                final shouldPop = await showDialog(
          context : context,
          builder: (context) => AlertDialog(
            title: Text('종료하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('예'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('아니요'),
              ),
            ],
          ),
        );
        return shouldPop ?? false; // 사용자의 선택이 없다면 기본값은 false
        // return Future(() => false);
      },
      child: ChangeNotifierProvider(
          create: (context) => MainViewModel(),
          child: Consumer<MainViewModel>(builder: (context, viewModel, child) {
            return Scaffold(
              body: IndexedStack(
                index: viewModel.currentIndex,
                children: [
                  MainBodyScreen(),
                  MemorialScreen(),
                  MypageScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: viewModel.currentIndex,
                onTap: (newIndex) {
                  viewModel.setCurrentIndex(newIndex);
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey[800],
                items: [
                  BottomNavigationBarItem(
                    icon: _customMenu(0, '홈으로', viewModel),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: _customMenu(1, '디지털 추모관', viewModel),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: _customMenu(2, '내 정보', viewModel),
                    label: '',
                  ),
                ],
              ),
            );
          })),
    );
  }

  Widget _customMenu(int index, String text, MainViewModel viewModel) {
    bool isSelected = viewModel.currentIndex == index;
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: isSelected ? themeColour5 : Colors.white,
      ),
    );
  }
}
