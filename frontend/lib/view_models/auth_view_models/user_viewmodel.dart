import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _user;
  final UserService _userService = UserService();

  UserModel? get user => _user;

  Future<void> fetchUserData() async {
    try {
      _user = await _userService.fetchUserData();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}