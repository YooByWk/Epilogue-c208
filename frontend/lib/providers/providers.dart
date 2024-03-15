import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_list_viewmodel.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_viewmodel.dart';


List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider(create: (context) => LoginViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialListViewModel()),
  // ChangeNotifierProvider(create: (context) => MemorialDetailViewModel()),
  // 이하 필요한 ViewModel 들을 추가 해주면 됩니다.
];