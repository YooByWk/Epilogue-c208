import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_body_screen.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/screens/mypage/mypage_screen.dart';
import 'package:frontend/view_models/main_view_models/main_viewmodel.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  // int alpha = 0;
  DateTime? _currentBackPressTime;
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('한번 더 누르면 종료됩니다.'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  DateTime? _lastPressedAt;

void handleBackPress(BuildContext context) {
  if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
    _lastPressedAt = DateTime.now();
    showSnackBar(context);
    return;
  }

  if (DateTime.now().difference(_lastPressedAt!) < Duration(seconds: 2)) {
    debugPrint('종료됩니다');
    SystemNavigator.pop();
  }
}

  void _switchTab(BuildContext context, int index) {
    Provider.of<MainViewModel>(context, listen: false).setCurrentIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        handleBackPress(context);
      
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainViewModel()),
          ChangeNotifierProvider(create: (context) => UserViewModel()),
        ],
          child: Consumer<MainViewModel>(builder: (context, viewModel, child) {
            return Scaffold(
              body: IndexedStack(
                index: Provider.of<MainViewModel>(context).currentIndex,
                children: [
                  MainBodyScreen(switchTab: (index) => _switchTab(context, index)),
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
