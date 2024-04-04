import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _isFocused = false;

  String get username => _username;
  String get password => _password;
  bool get isFocused => _isFocused;

  void setUsername(String value) {
    _username = value;
    debugPrint('id : ' + value);
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    debugPrint('password : ' + value);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  void login() {
    debugPrint('Username: $_username');
    debugPrint('Password: $_password');
    debugPrint('clicked login button!');
  }
}
