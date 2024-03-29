import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user/login_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:frontend/screens/login/login_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  LoginModel _loginData = LoginModel(username: '', password: '');
  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoginSuccess = false;

  // 네이버 로그인 정보
  String? accessToken;
  String? tokenType;
  String? refreshToken;

  String get password => _loginData.password;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  bool get isLoginSuccess => _isLoginSuccess;

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

///////////////////////////////////////////// 로그인
  Future<void> login() async {
    _isLoading = true;
    _errorMessage = null;
    debugPrint(_loginData.password);
    debugPrint(_loginData.username);
    notifyListeners();

    final result = await _authService.login(_loginData);
    _isLoading = false;

    if (!result['success']) {
      int statusCode = result['statusCode'];
      switch (statusCode) {
        case 401:
          _errorMessage = '로그인 정보가 잘못되었습니다.';
          break;
        case 500:
          _errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
          break;
        default:
          _errorMessage = '알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.';
      }
    } else {
      _errorMessage = null;
    }
    notifyListeners();
  }

  ///// 네이버 소셜 로그인
  Future<void> loginWithNaver() async {
    _isLoginSuccess = false;
    try {
      final NaverLoginResult user = await FlutterNaverLogin.logIn();
      final NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;

      accessToken = res.accessToken;
      tokenType = res.tokenType;
      refreshToken = res.refreshToken;

      String id = user.account.id;
      String name = user.account.name;
      String mobile = user.account.mobile
          .replaceAll('+82', '0')
          .replaceAll('-', '')
          .replaceAll(' ', '')
          .replaceAll('+', '');
      String birth = '${user.account.birthyear}${user.account.birthday}';
      notifyListeners();
      debugPrint(res.toString());
      debugPrint(res.accessToken);

      if (user.status == NaverLoginStatus.loggedIn) {
        _isLoginSuccess = await _authService.naverLogin(res.accessToken);
        if (_isLoginSuccess) {
          print('네이버 로그인 성공');
          debugPrint('accessToken = ${user.accessToken}');
        } else {
          print('네이버 로그인 실패');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
