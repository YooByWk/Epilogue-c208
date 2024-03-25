import 'package:flutter/material.dart';
import 'package:frontend/models/will/viewer_model.dart';

class ViewerViewModel extends ChangeNotifier {
  List<ViewerModel> _viewers = [];
  ViewerModel _viewerData = ViewerModel(
    viewerName: '',
    viewerEmail: '',
    viewerMobile: '',
  );
  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  List<ViewerModel> get viewers => _viewers;

  void setViewerName(String viewerName) {
    _viewerData = ViewerModel(
      viewerName: viewerName,
      viewerEmail: _viewerData.viewerEmail,
      viewerMobile: _viewerData.viewerMobile,
    );
    notifyListeners();
  }

  void setViewerEmail(String viewerEmail) {
    _viewerData = ViewerModel(
      viewerName: _viewerData.viewerName,
      viewerEmail: viewerEmail,
      viewerMobile: _viewerData.viewerMobile,
    );
    notifyListeners();
  }

  void setViewerMobile(String viewerMobile) {
    _viewerData = ViewerModel(
      viewerName: _viewerData.viewerName,
      viewerEmail: _viewerData.viewerEmail,
      viewerMobile: viewerMobile,
    );
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

    final result = await _viewerService.login(_loginData);
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
