import 'package:flutter/material.dart';


import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/memorial/memorial_screen.dart';
// import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/memorial/memorial_detail_screen.dart';


final Map<String, WidgetBuilder> mainRoutes = {
  '/login': (context) => LoginScreen(),
  '/memorial': (context) => MemorialScreen(),
  // '/main' : (context) => MainScreen(),

};




Route<dynamic> generateMainRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case '/memorial':
      return MaterialPageRoute(builder: (context) => MemorialScreen());

    // case '/main':
    //   return MaterialPageRoute(builder: (context) => MainScreen());
    case '/memorialDetail':
      return MaterialPageRoute(builder: (context) => MemorialDetailScreen());

    default:
      debugPrint('Route Error');
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}