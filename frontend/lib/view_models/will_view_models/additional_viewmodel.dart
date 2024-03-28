import 'package:flutter/material.dart';
import 'package:frontend/models/will/additional_model.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/services/will_service.dart';

class AdditionalViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  AdditionalModel _additionalData = AdditionalModel(sustainCare: '',
      funeralType: '',
      graveType: '',
      organDonation: '');

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String? get sustainCare => _additionalData.sustainCare;

  String? get funeralType => _additionalData.funeralType;

  String? get graveType => _additionalData.graveType;

  String? get organDonation => _additionalData.organDonation;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;


  void setSustainCare(String value) {
    _additionalData = AdditionalModel(sustainCare: value,
        funeralType: _additionalData.funeralType,
        graveType: _additionalData.graveType,
        organDonation: _additionalData.organDonation);
    notifyListeners();
  }

  void setFuneralType(String value) {
    _additionalData = AdditionalModel(sustainCare: _additionalData.sustainCare,
        funeralType: value,
        graveType: _additionalData.graveType,
        organDonation: _additionalData.organDonation);
    notifyListeners();
  }

  void setGraveType(String value) {
    _additionalData = AdditionalModel(sustainCare: _additionalData.sustainCare,
        funeralType: _additionalData.funeralType,
        graveType: value,
        organDonation: _additionalData.organDonation);
    notifyListeners();
  }

  void setOrganDonation(String value) {
    _additionalData = AdditionalModel(sustainCare: _additionalData.sustainCare,
        funeralType: _additionalData.funeralType,
        graveType: _additionalData.graveType,
        organDonation: value);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  Future<void> setAdditional() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.additionalInfo(_additionalData);
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
    }
    notifyListeners();
  }
}
