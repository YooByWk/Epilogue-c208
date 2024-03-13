import 'package:flutter/material.dart';


import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/memorial/memorial_screen.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  '/login': (context) => LoginScreen(),
  '/memorial': (context) => MemorialScreen(),
};
