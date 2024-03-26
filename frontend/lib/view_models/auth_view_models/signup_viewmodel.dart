import 'package:flutter/foundation.dart';
import 'package:frontend/models/signup_model.dart';
import 'package:frontend/services/auth_service.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  SignupModel _signupData =
      SignupModel(userId: '', password: '', name: '', mobile: '', birth: '');
  bool _isLoading = false;
  String? _errorMessage;

  SignupModel get signupData => _signupData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 비밀번호 유효성 검사
  bool validateSignupData() {

    // 비밀번호 확인과 일치 여부 판단
    if (_signupData.password != _confirmPassword) {
      _errorMessage = '비밀번호가 일치하지 않습니다.';
      notifyListeners();
      return false;
    }
    return true;
  }

  // // 비밀번호 유효성 검사 함수
  // bool validatePassword(String password) {
  //   Pattern pattern =
  //       r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).{8,16}$';
  //   RegExp regex = RegExp(pattern as String);
  //   return !regex.hasMatch(password);
  // }
  //
  // void setConfirmPassword(String value) {
  //   _confirmPassword = value;
  //   notifyListeners();
  // }

  void setUserId(String value) {
    _signupData = SignupModel(
        userId: value,
        password: _signupData.password,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: _signupData.birth);
    notifyListeners();
  }

  void setPassword(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: value,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: _signupData.birth);
    notifyListeners();
  }

  void setName(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: value,
        mobile: _signupData.mobile,
        birth: _signupData.birth);
    notifyListeners();
  }

  void setMobile(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: _signupData.name,
        mobile: value,
        birth: _signupData.birth);
    notifyListeners();
  }

  void setBirth(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: value);
    notifyListeners();
  }

  ////////////////////////////////////////////////
  Future<bool> checkUserId() async {
    return await _authService.checkUserId(_signupData.userId);
  }

///////////////////////////////////////////////////////
  Future<void> signup() async {
    // if (!validateSignupData()) {
    //   return;
    // }
    _isLoading = true;
    _errorMessage = null;
    debugPrint(_signupData.name);
    debugPrint(_signupData.userId);
    debugPrint(_signupData.password);
    debugPrint(_signupData.mobile);
    debugPrint(_signupData.birth);
    notifyListeners();

    await _authService.delToken();

    final result = await _authService.signup(_signupData);
    _isLoading = false;

    if (!result['success']) {
      int statusCode = result['statusCode'];
      switch (statusCode) {
        case 401:
          _errorMessage = '인증 실패. 다시 시도해주세요.';
          break;
        case 409:
          _errorMessage = '이미 가입된 사용자입니다.';
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
}
