import 'package:flutter/material.dart';
import 'package:frontend/models/will/witness_model.dart';
import 'package:frontend/services/will_service.dart';

class WitnessViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  List<WitnessModel> _witnessList = [];
  WitnessModel _witnessData = WitnessModel(
      witnessName: '', witnessEmail: '', witnessMobile: '');

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String get witnessName => _witnessData.witnessName;
  String? get witnessEmail => _witnessData.witnessEmail;
  String? get witnessMobile => _witnessData.witnessMobile;
  bool get isFocused => _isFocused;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<WitnessModel> get witnessList => _witnessList;


  void setWitnessName(String value) {
    _witnessData = WitnessModel(witnessName: value,
        witnessEmail: _witnessData.witnessEmail,
        witnessMobile: _witnessData.witnessMobile);
    notifyListeners();
  }

  void setWitnessEmail(String value) {
    _witnessData = WitnessModel(witnessName: _witnessData.witnessName,
        witnessEmail: value,
        witnessMobile: _witnessData.witnessMobile);
    notifyListeners();
  }

  void setWitnessMobile(String value) {
    _witnessData = WitnessModel(witnessName: _witnessData.witnessName,
        witnessEmail: _witnessData.witnessEmail,
        witnessMobile: value);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  Future<void> addWitness() async {

    WitnessModel newWitness = WitnessModel(
      witnessName: _witnessData.witnessName,
      witnessEmail: _witnessData.witnessEmail,
      witnessMobile: _witnessData.witnessMobile,
    );
    _witnessList.add(newWitness);

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
