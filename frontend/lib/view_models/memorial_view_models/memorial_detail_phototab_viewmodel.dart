import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoTabViewModel extends ChangeNotifier {
  List<String> _photos = [];
  int _nextItem = 0;

  List<String> get photos => _photos;

  Future<void> loadMore() async {
    // 데이터 로드
    debugPrint('Added item $_nextItem');
    for (int i = 0; i < 20; i++) {
      _photos.add('assets/images/ameno.jpg');
      _nextItem++;
    }
    notifyListeners();
  }
}
