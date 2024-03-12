import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create : (context)=> LoginViewModel() )
        // 이하 필요한 ViewModel 들을 추가해주면 됩니다.
      ],
      child: MaterialApp(
        title : 'E:pilogue',
        theme : ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home : LoginScreen() // Change this to the home screen of your app
      ),
    );  
    
  }
}
