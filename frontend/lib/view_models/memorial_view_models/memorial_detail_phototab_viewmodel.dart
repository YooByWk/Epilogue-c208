import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PhotoTabViewModel extends ChangeNotifier {
  List<String> _photos = [];
  int _nextItem = 0;

  List<String> get photos => _photos;

  PhotoTabViewModel() {
    loadInitialData();
  }
  
  void loadInitialData() {
    for (int i = 0; i < 20; i++) {
      _photos.add('assets/images/ameno.jpg');
      _nextItem++;
    }
  }

  Future<void> loadMore() async {
    // 데이터 로드
    debugPrint('Added item $_nextItem');
    for (int i = 0; i < 20; i++) {
      _photos.add('assets/images/ameno.jpg');
      _nextItem++;  // 다음 아이템을 가리키는 인덱스 증가
    }
    notifyListeners();  // 데이터가 변경되었음을 알림
  }

  void testAPI() async {
    // api 실험 호출
    String link = 'http://j10c208.p.ssafy.io:8080/api/test';
    debugPrint('API 호출 + $link');

    var res = await http.get(Uri.parse(link));

    if (res.statusCode == 200) {
      debugPrint('API 호출 성공');
    } else {
      debugPrint('API 호출 실패');
    }
    debugPrint(res.body);

    notifyListeners();
  }
}
