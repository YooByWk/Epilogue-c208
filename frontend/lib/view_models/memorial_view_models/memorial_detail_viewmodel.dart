import 'package:flutter/material.dart';
import 'package:frontend/models/memorial_detail_model.dart';
import 'package:frontend/services/memorial_service.dart';

class MemorialDetailViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();

  MemorialDetailViewModel() {
    getDetail();
  }

  MemorialDetailModel? _memorialDetailModel;
  bool _isLoading = false;
  String? _errorMessage;

  MemorialDetailModel? get memorialDetailModel => _memorialDetailModel;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> getDetail() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _memorialService.getDetail();
      if (!result['success']) {
        int statusCode = result['statusCode'];
        _errorMessage = statusCode == 500
            ? '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'
            : '알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.';
      } else {
        _memorialDetailModel = result['memorialDetailModel'];
      }
    } catch (e) {
      _errorMessage = '데이터 로딩 중 예외가 발생했습니다: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}