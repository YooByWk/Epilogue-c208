import 'package:flutter/foundation.dart';
import 'package:frontend/models/user/login_model.dart';
import 'package:frontend/models/user/signup_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  SignupModel _signupData = SignupModel(
      userId: '',
      password: '',
      name: '',
      mobile: '',
      birth: '',
      certificationNumber: '');
  bool _isLoading = false;
  String? _errorMessage;
  String? _confirmPassword;
  String? _userIdExists;

  SignupModel get signupData => _signupData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get confirmPassword => _confirmPassword;
  String? get userIdExists => _userIdExists;
  String get userId => _signupData.userId;
  String get password => _signupData.password;
  // 비밀번호 유효성 검사
  bool get isPasswordValid {
    String pattern =
        r'^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(_signupData.password);
  }

  // 핸드폰 번호 유효성 검사
  bool get isMobileValid {
    RegExp regex = RegExp(r'^010?([1-9]{4})?([0-9]{4})$');
    return regex.hasMatch(_signupData.mobile);
  }

  // 생년월일 유효성 검사
  bool get isBirthValid {
    RegExp regex =
        RegExp(r'^(19|20|21)\d{2}\.(0[1-9]|1[0-2])\.(0[1-9]|[12][0-9]|3[01])$');
    return regex.hasMatch(_signupData.birth);
  }

  // 비밀번호 확인 일치 여부
  bool get isPasswordSame => _signupData.password == _confirmPassword;

  // 폼 유효성 검사 로직
  bool get isFormValid {
    bool isFieldNotEmpty = signupData.userId.isNotEmpty &&
        _signupData.password.isNotEmpty &&
        _signupData.name.isNotEmpty &&
        _signupData.mobile.isNotEmpty &&
        _signupData.certificationNumber.isNotEmpty &&
        _signupData.birth.isNotEmpty &&
        _confirmPassword != null &&
        _confirmPassword!.isNotEmpty;

    return isFieldNotEmpty &&
        isPasswordSame &&
        isPasswordValid &&
        isMobileValid &&
        isBirthValid;
  }

  void setConfirmPassword(String? value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void setUserId(String value) {
    _signupData = SignupModel(
        userId: value,
        password: _signupData.password,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: _signupData.birth,
        certificationNumber: _signupData.certificationNumber);
    notifyListeners();
  }

  void setPassword(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: value,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: _signupData.birth,
        certificationNumber: _signupData.certificationNumber);
    notifyListeners();
  }

  void setName(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: value,
        mobile: _signupData.mobile,
        birth: _signupData.birth,
        certificationNumber: _signupData.certificationNumber);
    notifyListeners();
  }

  void setMobile(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: _signupData.name,
        mobile: value,
        birth: _signupData.birth,
        certificationNumber: _signupData.certificationNumber);
    notifyListeners();
  }

  void setBirth(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: value,
        certificationNumber: _signupData.certificationNumber);
    notifyListeners();
  }

  void setCertificationNumber(String value) {
    _signupData = SignupModel(
        userId: _signupData.userId,
        password: _signupData.password,
        name: _signupData.name,
        mobile: _signupData.mobile,
        birth: _signupData.birth,
        certificationNumber: value);
    notifyListeners();
  }

  ////////////////////////////////////////////////휴대폰 인증
  Future<void> mobileCertificationSend() async {
    _isLoading = true;
    notifyListeners();

    await _authService.mobileCertificationSend(_signupData.mobile);
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> verifyCode() async {
    _isLoading = true;
    notifyListeners();

    bool result = await _authService.mobileCertificationConfirm(
        _signupData.mobile, _signupData.certificationNumber);

    _isLoading = false;
    notifyListeners();
    return result;
  }

  ////////////////////////////////////////////////아이디 중복체크
  Future<void> checkUserId() async {
    _isLoading = true;
    notifyListeners();

    bool isAvailable = await _authService.checkUserId(_signupData.userId);
    _isLoading = false;

    if (isAvailable) {
      _userIdExists = '이미 사용 중인 아이디입니다.';
    } else {
      _userIdExists = null;
    }
    notifyListeners();
  }

///////////////////////////////////////////////////////회원가입
  Future<void> signup() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // 폼 유효성 검사 추가
    // if (!isFormValid) {
    //   _isLoading = false;
    //   _errorMessage = "입력한 정보를 다시 확인해주세요.";
    //   notifyListeners();
    //   return;
    // }

    if (_userIdExists != null) {
      _isLoading = false;
      _errorMessage = _userIdExists;
      notifyListeners();
      return;
    }

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
      debugPrint('회원가입 성공, 로그인 시도');
      final loginResult = await _authService.login(
        LoginModel(username: _signupData.userId, password: _signupData.password),
      );
      if (loginResult['success']) {
        await UserViewModel().fetchUserData().then((_)=> { debugPrint('로그인 후 유저 정보 불러오기 성공') });
      }
      if (!loginResult['success']) {
        int statusCode = loginResult['statusCode'];
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
      }
    }
    notifyListeners();
  }

}
