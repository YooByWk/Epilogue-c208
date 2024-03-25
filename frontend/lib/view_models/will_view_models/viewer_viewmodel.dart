import 'package:flutter/material.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/services/will_service.dart';

class ViewerViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  List<ViewerModel> viewerList = [];
  ViewerModel _viewerData = ViewerModel(
      viewerName: '', viewerEmail: '', viewerMobile:'');

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String get viewerName => _viewerData.viewerName;
  String? get viewerEmail => _viewerData.viewerEmail;
  String? get viewerMobile => _viewerData.viewerMobile;
  bool get isFocused => _isFocused;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void addViewer() {
    viewerList.add(ViewerModel(viewerName: _viewerData.viewerName,
        viewerEmail: _viewerData.viewerEmail,
        viewerMobile: _viewerData.viewerMobile));
  }

  void sendViewer() {
    _willService.sendViewer(viewerList);
  }

  void setViewerName(String value) {
    _viewerData = ViewerModel(viewerName: value,
        viewerEmail: _viewerData.viewerEmail,
        viewerMobile: _viewerData.viewerMobile);
    notifyListeners();
  }

  void setViewerEmail(String value) {
    _viewerData = ViewerModel(viewerName: _viewerData.viewerName,
        viewerEmail: value,
        viewerMobile: _viewerData.viewerMobile);
    notifyListeners();
  }

  void setViewerMobile(String value) {
    _viewerData = ViewerModel(viewerName: _viewerData.viewerName,
        viewerEmail: _viewerData.viewerEmail,
        viewerMobile: value);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  Future<void> setViewer() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.sendViewer(viewerList);
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
