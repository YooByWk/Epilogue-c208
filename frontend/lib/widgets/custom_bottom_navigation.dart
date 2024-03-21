import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/screens/mypage/mypage_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  CustomBottomNavigation({super.key});

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          MainScreen(),
          MemorialScreen(),
          MypageScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[800],
        items: [
          BottomNavigationBarItem(
            icon: _customMenu(0, '홈으로'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _customMenu(1, '디지털 추모관'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _customMenu(2, '내 정보'),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _customMenu(int index, String text) {
    bool isSelected = currentIndex == index;
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
