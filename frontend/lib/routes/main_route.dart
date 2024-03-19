import 'package:flutter/material.dart';

import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_screen.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/widgets/custom_bottom_navigation.dart';
import 'package:frontend/screens/letter/letter_screen.dart';
import 'package:frontend/screens/will/will_screen.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  '/login': (context) => LoginScreen(),
  '/memorial': (context) => MemorialScreen(),
  '/home': (context) => CustomBottomNavigation(),
  '/letter': (context) => LetterScreen(),
};

Route<dynamic> generateMainRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case '/memorial':
      return MaterialPageRoute(builder: (context) => MemorialScreen());

    case '/home':
      return MaterialPageRoute(builder: (context) => CustomBottomNavigation());

    case '/letter':
      return MaterialPageRoute(builder: (context) => LetterScreen());

    case '/memorialDetail':
      return MaterialPageRoute(
          builder: (context) => MemorialDetailScreen(),
          settings: RouteSettings(arguments: settings.arguments));

    default:
      debugPrint('Route Error');
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
