import 'package:flutter/material.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/services/will_service.dart';


class ViewerViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  List<ViewerModel> _viewerList = [];
  ViewerModel _viewerData = ViewerModel(
      viewerName: '', viewerEmail: '', viewerMobile: '');

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String get viewerName => _viewerData.viewerName;
  String? get viewerEmail => _viewerData.viewerEmail;
  String? get viewerMobile => _viewerData.viewerMobile;
  bool get isFocused => _isFocused;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ViewerModel> get viewerList => _viewerList;

  // 핸드폰 번호 유효성 검사
  bool get isMobileValid {
    RegExp regex = RegExp(r'^010?([1-9]{4})?([0-9]{4})$');
    return regex.hasMatch(_viewerData.viewerMobile ?? '');
  }

  // 이메일 유효성 검사
  bool get isEmailValid {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(_viewerData.viewerEmail ?? '');
  }

  // 폼 유효성 검사
  bool get isFormValid {
    bool isMobileOrEmailValid = isEmailValid || isMobileValid;
    bool isNameNotEmpty = _viewerData.viewerName.isNotEmpty;
    return isNameNotEmpty && isMobileOrEmailValid;
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

  Future<void> addViewer() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // 새로운 ViewerModel 인스턴스를 생성하여 List에 추가
    ViewerModel newViewer = ViewerModel(
      viewerName: _viewerData.viewerName,
      viewerEmail: _viewerData.viewerEmail,
      viewerMobile: _viewerData.viewerMobile,
    );
    _viewerList.add(newViewer);
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
    _viewerData.viewerName = '';
    _viewerData.viewerEmail = '';
    _viewerData.viewerMobile = '';
  }

  Future<void> deleteViewer(int index) async {
    _viewerList.removeAt(index);
    notifyListeners();
  }

  Future<void> setViewer() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.sendViewer(_viewerList);

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
      _viewerList.clear();
    }
    notifyListeners();
  }
}
