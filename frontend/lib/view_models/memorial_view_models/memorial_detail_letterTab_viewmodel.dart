import 'package:flutter/material.dart';
import 'package:frontend/models/letter_model.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_letter_tab.dart';
import 'package:provider/provider.dart';

class LetterViewModel extends ChangeNotifier {
  List<LetterModel> _letters = [];
  int _idx = 0;

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
