import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_letter_list_model.dart';
import 'package:frontend/models/memorial_letter_upload_model.dart';
import 'package:frontend/services/memorial_service.dart';

class LetterTabViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();
  List<MemorialLetterListModel> _letters = [];

  LetterUploadModel _letterData = LetterUploadModel(
    nickname: '',
    content: '',
  );

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String? get nickname => _letterData.nickname;

  String? get content => _letterData.content;

  List<MemorialLetterListModel> get letters => _letters;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void updateLetter() {
    notifyListeners();
  }

  LetterTabViewModel() {
    loadInitialData();
  }

  void loadInitialData() async {
    _letters = [];
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lastLetterSeq = _letters.isNotEmpty ? _letters.last.memorialLetterSeq : 0;
    final result = await _memorialService.letterList(lastLetterSeq: lastLetterSeq);
    if (!result['success']) {
      int statusCode = result['statusCode'];
      switch (statusCode) {
        case 500:
          _errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
          break;
        case 403:
          _errorMessage = '로그인 후 이용할 수 있습니다.';
        default:
          _errorMessage = '알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.';
      }
    } else {
      _letters = result['letterList'];
      _isLoading = false;
    }
    notifyListeners(); // 데이터가 변경되었음을 알림
  }

  Future<void> loadMore() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lastLetterSeq = _letters.isNotEmpty ? _letters.last.memorialLetterSeq : 0;
    final result = await _memorialService.letterList(lastLetterSeq: lastLetterSeq);
    // _letters의 길이가 전체 개수면 그만!
    if (_letters.length.toString() == result['count']) {
      _isLoading = false; // 데이터를 더 불러오지 않음
      notifyListeners();
      return;
    }

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
      _letters.addAll(result['letterList']);
      _isLoading = false;
    }
    notifyListeners();
  }


  void setNickname(String value) {
    _letterData =
        LetterUploadModel(nickname: value, content: _letterData.content);
    notifyListeners();
  }

  void setContent(String value) {
    _letterData =
        LetterUploadModel(nickname: _letterData.nickname, content: value);
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  Future uploadLetter() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    /// 편지 업로드
    final result = await _memorialService.letterUpload(_letterData);
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
      final result = await _memorialService.letterList(lastLetterSeq: 0);
      if (!result['success']) {
        int statusCode = result['statusCode'];
        switch (statusCode) {
          case 500:
            _errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
            break;
          case 403:
            _errorMessage = '로그인 후 이용할 수 있습니다.';
          default:
            _errorMessage = '알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.';
        }
      } else {
        _letters = result['letterList'];
        _isLoading = false;
        return _letters;
      }
      notifyListeners(); // 데이터가 변경되었음을 알림

      _errorMessage = null;
    }
    notifyListeners();
  }


}
