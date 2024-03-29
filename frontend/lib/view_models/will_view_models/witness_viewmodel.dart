import 'package:flutter/material.dart';
import 'package:frontend/models/will/witness_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/will_service.dart';

class WitnessViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  final AuthService _authService = AuthService();
  List<WitnessModel> _witnessList = [];
  WitnessModel _witnessData = WitnessModel(
      witnessName: '',
      witnessEmail: '',
      witnessMobile: '',
      witnessCertificationNumber: '');

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isCodeVerified = false; // verifyCode 성공여부 저장

  String get witnessName => _witnessData.witnessName;

  String get witnessEmail => _witnessData.witnessEmail;

  String get witnessMobile => _witnessData.witnessMobile;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<WitnessModel> get witnessList => _witnessList;

  ////////////////////////////////////////////////휴대폰 인증
  Future<void> mobileCertificationSend() async {
    _isLoading = true;
    notifyListeners();

    await _authService.mobileCertificationSend(_witnessData.witnessMobile);
    debugPrint('핸드폰 문자를 보세요!!!!!!!!!!!!!!');
    _isLoading = false;
    notifyListeners();
  }

  ////////////////////// 인증 번호
  Future<bool> verifyCode() async {
    _isLoading = true;
    notifyListeners();

    bool result = await _authService.mobileCertificationConfirm(
        _witnessData.witnessMobile, _witnessData.witnessCertificationNumber);

    if (result) {
      _isCodeVerified = true;
    }
    _isLoading = true;
    notifyListeners();
    return _isCodeVerified;
  }

  // 핸드폰 번호 유효성 검사
  bool get isMobileValid {
    RegExp regex = RegExp(r'^010?([1-9]{4})?([0-9]{4})$');
    return regex.hasMatch(_witnessData.witnessMobile);
  }

  // 이메일 유효성 검사
  bool get isEmailValid {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(_witnessData.witnessEmail ?? '');
  }

  // 폼 유효성 검사
  bool get isFormValid {
    bool isFieldNotEmpty = _witnessData.witnessName.isNotEmpty &&
        _witnessData.witnessMobile.isNotEmpty &&
        _witnessData.witnessEmail.isNotEmpty &&
        _witnessData.witnessCertificationNumber.isNotEmpty;
    return isFieldNotEmpty && isEmailValid && isMobileValid;
  }

  // 인증 번호
  void setCertificationNumber(String value) {
    _witnessData = WitnessModel(
        witnessName: _witnessData.witnessName,
        witnessMobile: _witnessData.witnessMobile,
        witnessEmail: _witnessData.witnessEmail,
        witnessCertificationNumber: value);
  }

  void setWitnessName(String value) {
    _witnessData = WitnessModel(
        witnessName: value,
        witnessEmail: _witnessData.witnessEmail,
        witnessMobile: _witnessData.witnessMobile,
        witnessCertificationNumber: _witnessData.witnessCertificationNumber);
    notifyListeners();
  }

  void setWitnessEmail(String value) {
    _witnessData = WitnessModel(
        witnessName: _witnessData.witnessName,
        witnessEmail: value,
        witnessMobile: _witnessData.witnessMobile,
        witnessCertificationNumber: _witnessData.witnessCertificationNumber);
    notifyListeners();
  }

  void setWitnessMobile(String value) {
    _witnessData = WitnessModel(
        witnessName: _witnessData.witnessName,
        witnessEmail: _witnessData.witnessEmail,
        witnessMobile: value,
        witnessCertificationNumber: _witnessData.witnessCertificationNumber);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  /////////////// 증인 추가 //////////////////////
  Future<void> addWitness() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // if (!isFormValid) {
    //   _errorMessage = '모든 필드의 정보를 정확히 입력해주세요.';
    //   _isLoading = false;
    //   notifyListeners();
    //   return;
    // }
    //
    // if (!_isCodeVerified) {
    //   _errorMessage = '핸드폰 인증이 확인되지 않았습니다.';
    //   _isLoading = false;
    //   notifyListeners();
    //   return;
    // }

    WitnessModel newWitness = WitnessModel(
      witnessName: _witnessData.witnessName,
      witnessEmail: _witnessData.witnessEmail,
      witnessMobile: _witnessData.witnessMobile,
      witnessCertificationNumber: _witnessData.witnessCertificationNumber,
    );
    _witnessList.add(newWitness);
    _errorMessage = null;
    _isLoading = false;
    _witnessData.witnessName = '';
    _witnessData.witnessEmail = '';
    _witnessData.witnessMobile = '';
    notifyListeners();
  }

  Future<void> deleteWitness(int index) async {
    _witnessList.removeAt(index);
    notifyListeners();
  }

  Future<void> setWitness() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.sendWitness(_witnessList);

    _isLoading = false;

    if (!result['success']) {
      int statusCode = result['statusCode'];
      switch (statusCode) {
        case 500:
          _errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
          break;
        default:
          _errorMessage = '알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.';
      }
    } else {
      _errorMessage = null;
      _witnessList.clear();
    }
    notifyListeners();
  }
}
