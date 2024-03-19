import 'package:flutter/material.dart';
import 'package:frontend/models/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  LoginModel _loginData = LoginModel(userId: '', password: '');
  bool _isFocused = false;

  String get email => _loginData.userId;
  String get password => _loginData.password;
  bool get isFocused => _isFocused;

  void setUserId(String value) {
    _loginData = LoginModel(userId: value, password : _loginData.password);
  }

  void setPassword(String value) {
    _loginData = LoginModel(userId : _loginData.userId, password : value); 
  }

  void setFocused(bool value) {
    _isFocused = value;
  }

  void login() async {
    debugPrint('로그인 정보 : 아이디 ${_loginData.userId},  PW ${_loginData.password}');
  }


}