import 'package:flutter/material.dart';
import 'package:frontend/view_models/login_view_models/login_viewmodel.dart';
import 'package:frontend/view_models/signup_view_models/signup_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/viewer_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_viewmodel.dart';
import 'package:frontend/view_models/main_view_models/main_viewmodel.dart';


List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider(create: (context) => LoginViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialListViewModel()),
  // ChangeNotifierProvider(create: (context) => MemorialDetailViewModel()),
  // 이하 필요한 ViewModel 들을 추가 해주면 됩니다.
  ChangeNotifierProvider(create: (context) => MainViewModel()),
  ChangeNotifierProvider(create: (context) => SignupViewModel()),
  // ChangeNotifierProvider(create: (context) => ViewerViewModel()),
];