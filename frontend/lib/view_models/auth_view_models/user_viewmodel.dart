import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  final UserService _userService = UserService();

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  UserViewModel() {
    fetchUserData();
  }

  // 유저 정보 불러오기
  Future<void> fetchUserData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint('fetchUserData() 호출됨');
      _user = await _userService.fetchUserData();
      debugPrint(_user != null ? _user?.toJson().toString() : 'user null');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // 유저 정보 수정
Future<void> modifyUserData(String name, String mobile) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    UserModel updateUser = await _userService.modifyUserData(name, mobile);
    _user = updateUser;
    _isLoading = false;
    notifyListeners();
  } catch (e) {
    debugPrint(e.toString());
    _isLoading = false;
    _errorMessage = '정보 수정에 실패했습니다.';
    notifyListeners();
  }
}
}