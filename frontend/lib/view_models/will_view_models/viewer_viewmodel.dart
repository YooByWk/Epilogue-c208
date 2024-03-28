import 'package:flutter/material.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/services/will_service.dart';

class ViewerViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  List<ViewerModel> _viewerList = [];
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
  List<ViewerModel> get viewerList => _viewerList;


  void sendViewer() {
    _willService.sendViewer(_viewerList);
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
    debugPrint(_viewerData.viewerName);
    // 새로운 ViewerModel 인스턴스를 생성하여 List에 추가
    ViewerModel newViewer = ViewerModel(
      viewerName: _viewerData.viewerName,
      viewerEmail: _viewerData.viewerEmail,
      viewerMobile: _viewerData.viewerMobile,
    );
    _viewerList.add(newViewer);

    notifyListeners();

    // 디버그 출력을 위해 새로운 인스턴스의 이름과 전체 리스트 출력
    debugPrint(newViewer.viewerName);
    for (var viewer in _viewerList) {
      debugPrint('${viewer.viewerName}'); // 리스트 내의 각 Viewer 이름 출력
    }
  }

  Future<void> setViewer() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.sendViewer(_viewerList);
    // debugPrint('$viewerList');
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
