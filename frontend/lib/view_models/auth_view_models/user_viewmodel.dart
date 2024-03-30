import 'package:flutter/material.dart';
import 'package:frontend/models/user/user_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  final _storage = FlutterSecureStorage();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  UserModel? get user => _user;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  UserViewModel() {
    fetchUserData();
  }

  // // 유저 정보 불러오기
  Future<void> fetchUserData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      String? userJson = await _storage.read(key: 'userInfo');
      if (userJson != null) {
        Map<String, dynamic> userMap = json.decode(userJson);
        _user = UserModel.fromJson(userMap);
      } else {
        // 로컬 저장소에 유저 정보가 없는 경우 서버에서 유저 정보를 가져옴
        _user = await _userService.fetchUserData();
        // 서버에서 불러온 유저 정보를 로컬 저장소에 저장
        String newUserJson = json.encode(_user!.toJson());
        await _storage.write(key: 'userInfo', value: newUserJson);
        // 유저 아이디만 따로 저장
        await _storage.write(key: 'userId', value:  _user!.userId);
      }
    } catch (e) {
      _errorMessage = '유저 정보 불러오기 실패';
      debugPrint(_errorMessage);
    } finally {
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

  // 로그아웃
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }


    Future<String> fetchUserId() async {
      print('fetchUserId() called ${_storage.read(key: 'userInfo')}');
    String? userJson = await _storage.read(key: 'userInfo');
    if (userJson == null) {
      throw Exception('User info not found');
    }
    
    
    UserModel user = UserModel.fromJson(json.decode(userJson));
    print('유저 : $user.userId');
    return user.userId;
  }
}
