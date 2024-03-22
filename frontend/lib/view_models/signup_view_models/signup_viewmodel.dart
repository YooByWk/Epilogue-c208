import 'package:flutter/foundation.dart';
import 'package:frontend/models/signup_model.dart';
import 'package:frontend/providers/auth_service.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  SignupModel _signupData =
      SignupModel(userId: '', password: '', name: '', mobile: '', birth: '');
  String _confirmPassword = '';
  bool _isLoading = false;
  bool _isSuccessful = false;
  String? _errorMessage;

  SignupModel get signupData => _signupData;

  bool get isLoading => _isLoading;

  bool get isSuccessful => _isSuccessful;

  String? get errorMessage => _errorMessage;

  bool validateSignupData() {
    // 비밀번호 유효성 검사
    if (!validatePassword(_signupData.password)) {
      _errorMessage = '비밀번호는 8~16자리 영문 대소문자, 숫자, 특수문자를 포함해야 합니다.';
      notifyListeners();
      return false;
    }

    if (_signupData.password != _confirmPassword) {
      _errorMessage = '비밀번호가 일치하지 않습니다.';
      notifyListeners();
      return false;
    }
    return true;
  }

  // 비밀번호 유효성 검사 함수
  bool validatePassword(String password) {
    Pattern pattern =
        r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).{8,16}$';
    RegExp regex = RegExp(pattern as String);
    return !regex.hasMatch(password);
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

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

  Future<void> signup() async {
    if (!validateSignupData()) {
      return;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool result = await _authService.signup(_signupData);
      _isSuccessful = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
