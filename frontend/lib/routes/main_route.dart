import 'package:flutter/material.dart';

import 'package:frontend/screens/block_chain_test.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_screen.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/letter/letter_screen.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  '/login': (context) => LoginScreen(),
  '/memorial': (context) => MemorialScreen(),
  '/home': (context) => MainScreen(),
  '/letter': (context) => LetterScreen(),
};

Route<dynamic> generateMainRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case '/memorial':
      return MaterialPageRoute(builder: (context) => MemorialScreen());

    case '/home':
      return MaterialPageRoute(builder: (context) => MainScreen());

    case '/letter':
      return MaterialPageRoute(builder: (context) => LetterScreen());

    case '/memorialDetail':
      return MaterialPageRoute(
          builder: (context) => MemorialDetailScreen(),
          settings: RouteSettings(arguments: settings.arguments));

    case '/blockChain':
      return MaterialPageRoute(builder: (context) => BlockChainTest());

    default:
      debugPrint('Route Error');
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
