import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:frontend/routes/main_route.dart';

import 'package:frontend/screens/memorial/memorial_list_viewmodel.dart';

const Color themeColour1 = Color(0xFFF0EBE3);
const Color themeColour2 = Color(0xFFE4DCCF);
const Color themeColour3 = Color(0xFFADC2A9);
const Color themeColour4 = Color(0xFF99A799);
const Color themeColour5 = Color(0xFF617C77);
const Color whiteText = Color(0xFFFFFFFF);
const Color blackText = Color(0xFF121212);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => MemorialListViewModel()),
        // 이하 필요한 ViewModel 들을 추가해주면 됩니다.
      ],
      child: MaterialApp(
          routes: {...mainRoutes},
          title: 'E:pilogue',
          theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: LoginScreen() // Change this to the home screen of your app
          ),
    );
  }
}
