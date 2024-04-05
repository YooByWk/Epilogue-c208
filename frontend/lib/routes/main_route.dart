import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/login/mnemonic_recovery_screen.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_screen.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_photo_detail.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/mypage/mypage_screen.dart';
import 'package:frontend/screens/signup/mnemonic_show_screen.dart';
import 'package:frontend/screens/will/will_open_viewer_screen.dart';
final Map<String, WidgetBuilder> mainRoutes = {
  '/login': (context) => LoginScreen(),
  '/memorial': (context) => MemorialScreen(),
  '/home': (context) => MainScreen(),
};

Route<dynamic> generateMainRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case '/memorial':
      return MaterialPageRoute(builder: (context) => MemorialScreen());

    case '/home':
      return MaterialPageRoute(builder: (context) => MainScreen());

    case '/open':
      return MaterialPageRoute(builder: (context) => WillOpenViewerScreen());

    case '/mypage':
      return MaterialPageRoute(builder: (context) => MypageScreen());

    case '/memorialDetail':
      return MaterialPageRoute(
          builder: (context) => MemorialDetailScreen(),
          settings: RouteSettings(arguments: settings.arguments));

    case '/memorialPhotoDetail':
      return MaterialPageRoute(
          builder: (context) => MemorialPhotoDetailScreen(),
          settings: RouteSettings(arguments: settings.arguments));

    case '/mnemonic':
      // return MaterialPageRoute(builder: (context) => MnemonicShowScreen());

      return MaterialPageRoute(builder: (context) => MnemonicRecoveryScreen());

    case '/myMnemonic':
      return MaterialPageRoute(builder: (context) => MnemonicShowScreen());
      // return MaterialPageRoute(builder: (context) => MnemonicRecoveryScreen());

    default:
      debugPrint('Route Error');
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
