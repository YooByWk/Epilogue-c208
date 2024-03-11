import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String _username = '';
  String _password = '';

  String get username => _username;
  String get password => _password;

  void setUsername(String value) {
    _username = value;
    // notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    // notifyListeners();
  }

  void login() {
    debugPrint(_username,);
    debugPrint(_password,);
    print(password);
    debugPrint('clicked login button!');
  }
}
