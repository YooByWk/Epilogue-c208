import 'package:flutter/material.dart';
import 'package:frontend/models/login_model.dart';
import 'package:frontend/providers/providers.dart';

class LoginViewModel extends ChangeNotifier {

  LoginModel _loginData = LoginModel(username: '', password: '');
  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String get password => _loginData.password;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void setUsername(String value) {
    _loginData = LoginModel(username: value, password: _loginData.password);
  }

  void setPassword(String value) {
    _loginData = LoginModel(username: _loginData.username, password: value);
  }

  void setFocused(bool value) {
    _isFocused = value;
  }

  void login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

  }
}
