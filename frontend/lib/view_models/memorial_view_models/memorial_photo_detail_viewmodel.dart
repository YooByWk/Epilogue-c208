import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_photo_detail_model.dart';
import 'package:frontend/models/memorial_detail_model.dart';
import 'package:frontend/services/memorial_service.dart';

class MemorialPhotoDetailViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();

  MemorialPhotoDetailViewModel() {
    getDetail();
  }

  late MemorialPhotoDetailModel? _memorialPhotoDetailModel;
  bool _isLoading = false;
  String? _errorMessage;

  MemorialPhotoDetailModel? get memorialPhotoDetailModel =>
      _memorialPhotoDetailModel;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> getDetail() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _memorialService.photoDetail();
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
      _memorialPhotoDetailModel = result['memorialPhotoDetailModel'];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reportPhoto() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _memorialService.reportPhoto();
    if (!result['success']) {
      int statusCode = result['statusCode'];
      switch (statusCode) {
        case 500:
          _errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
          break;
        case 403:
          _errorMessage = '신고하려면 로그인을 해야 합니다.';
        default:
          _errorMessage = '알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.';
      }
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }
}
