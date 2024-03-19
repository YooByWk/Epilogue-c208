import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/screens/mypage/mypage_screen.dart';

class CustomBottomNavigation extends StatefulWidget {

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List pages = [
    MainScreen(),
    MypageScreen(),
    MemorialScreen(),
  ];
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: IndexedStack(
      index: _selectedIndex,
      children: pages,
    ),
    padding: EdgeInsets.all(10),
    color: Colors.grey[800],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () => _onItemTapped(0),
            icon: Icon(Icons.home),
            _selectedIndex == 0 ? themeColour5 : Colors.white),
        IconButton(
            onPressed: () => _onItemTapped(1),
            icon: Icon(Icons.flare),
            _selectedIndex == 1 ? themeColour5 : Colors.white),
        IconButton(
            onPressed: () => _onItemTapped(2),
            icon: Icon(Icons.person),
            _selectedIndex == 2 ? themeColour5 : Colors.white),
      ],
    ),
  );
}
}