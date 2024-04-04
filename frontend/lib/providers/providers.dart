import 'package:flutter/material.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:frontend/models/block_chain_will_model.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/view_models/auth_view_models/login_viewmodel.dart';
import 'package:frontend/view_models/auth_view_models/signup_viewmodel.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_letterTab_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_phototab_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_videotab_viewmodel.dart';
import 'package:frontend/view_models/block_chain/block_chain_will_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_photo_detail_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_video_detail_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/additional_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/memorial_name_picture_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/memorial_use_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/recording_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/viewer_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_viewmodel.dart';
import 'package:frontend/view_models/main_view_models/main_viewmodel.dart';
import 'package:frontend/routes/main_route.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider(create: (context) => LoginViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialListViewModel()),
  // ChangeNotifierProvider(create: (context) => MemorialDetailViewModel()),
  // 이하 필요한 ViewModel 들을 추가 해주면 됩니다.
  ChangeNotifierProvider(create: (context) => MainViewModel()),
  ChangeNotifierProvider(create: (context) => SignupViewModel()),
  ChangeNotifierProvider(create: (context) => BlockChainWalletViewModel(BlockChainWalletModel())),
  ChangeNotifierProvider(create: (context) => ViewerViewModel()),
  ChangeNotifierProvider(create: (context) => AdditionalViewModel()),
  ChangeNotifierProvider(create: (context) => RecordingViewModel()),
  ChangeNotifierProvider(create: (context) => UserViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialUseViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialNamePictureViewModel()),
  ChangeNotifierProvider(create: (context) => PhotoTabViewModel()),
  ChangeNotifierProvider(create: (context) => VideoTabViewModel()),
  ChangeNotifierProvider(create: (context) => LetterTabViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialListViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialDetailViewModel()),
  ChangeNotifierProvider(create: (context) => BlockChainWillViewModel()),
  // ChangeNotifierProvider(create: (context) => UserViewModel()),

  ChangeNotifierProvider(create: (context) => MemorialPhotoDetailViewModel()),
  ChangeNotifierProvider(create: (context) => MemorialVideoDetailViewModel()),
  // ChangeNotifierProvider(create :(context) => RecordingViewModel())
];

Widget setupProvider() {
  return MultiProvider(
    providers: providers,
    child: MaterialApp(
      title: 'E:pilogue',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: LoginScreen(),
      onGenerateRoute: generateMainRoute,
    ),
  );
}
