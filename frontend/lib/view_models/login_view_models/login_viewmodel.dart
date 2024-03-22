import 'package:flutter/material.dart';
import 'package:frontend/models/login_model.dart';
import 'package:frontend/providers/auth_service.dart';


class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  LoginModel _loginData = LoginModel(username: '', password: '');
  bool _isFocused = false;
  bool _isLoading = false;
  bool _isSuccessful = false;
  String? _errorMessage;

  String get password => _loginData.password;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  bool get isSuccessful => _isSuccessful;

  String? get errorMessage => _errorMessage;

  void setUsername(String value) {
    _loginData = LoginModel(username: value, password: _loginData.password);
    notifyListeners();
  }

  void setPassword(String value) {
    _loginData = LoginModel(username: _loginData.username, password: value);
    debugPrint(password);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

/////////////////////////////////////////////
  Future<void> login() async {
    _isLoading = true;
    _isSuccessful = false;
    _errorMessage = null;
    debugPrint(_loginData.password);
    debugPrint(_loginData.username);
    // notifyListeners();

    try {
      bool result = await _authService.login(_loginData);
      if (result) {
        _isSuccessful = true;
      } else {
        _errorMessage = '로그인 실패';
      }
    } catch (e) {
      _errorMessage = '${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
