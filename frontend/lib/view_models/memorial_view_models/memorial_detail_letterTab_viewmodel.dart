import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_letter_list_model.dart';
import 'package:frontend/models/memorial_letter_upload_model.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_letter_tab.dart';
import 'package:frontend/screens/memorial/memorial_letter_upload.dart';
import 'package:frontend/services/memorial_service.dart';
import 'package:provider/provider.dart';

class LetterTabViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();

  List<LetterModel> _letters = [];

  LetterUploadModel _letterData = LetterUploadModel(
    nickname: '',
    content: '',
  );

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String? get nickname => _letterData.nickname;

  String? get content => _letterData.content;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;
  int _idx = 0;

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

  Future<void> uploadLetter() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

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
      _errorMessage = null;
    }
    notifyListeners();
  }

  List<LetterModel> get letters => _letters;

  void updateLetter(LetterModel letter) {
    // 새로운 편지 불러오기
    _letters.add(letter);
    notifyListeners();
  }

  LetterViewModel() {
    loadInitialData();
    debugPrint('편지 뷰모델 생성');
  }

  void loadInitialData() {
    for (int i = 0; i < 20; i++) {
      _letters.add(LetterModel(
        title: '편지 내용 $i',
        content: '편지 내용 $i',
        date: DateTime.now(),
      ));
      _idx++; // 편지 인덱스 증가
    }
    notifyListeners(); // 데이터가 변경되었음을 알림
  }

  Future<void> loadMore() async {
    // 데이터 로드
    for (int i = 0; i < 20; i++) {
      _letters.add(LetterModel(
        title: '편지 내용 $_idx',
        content: '편지 내용 $_idx',
        date: DateTime.now(),
      ));
      _idx++;
    }
    notifyListeners();
  }

}
