import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 

class VideoTabViewModel extends ChangeNotifier {
  List<String> _videos = [];
  int _nextItem = 0 ;



  List<String> get videos => _videos;

  VideoTabViewModel() {
    loadInitialData();
  }

  void loadInitialData() {
    for (int i = 0; i < 10; i++) {
      _videos.add('assets/images/memorialTest/test_video.mp4');
      _nextItem++;
    }
      debugPrint('초기 데이터 추가 : 추모관 비디오 탭');
  }

  Future<void> loadMore() async {
    // 비디오 로드

    for (int i =0; i < 10; i++) {
      _videos.add('assets/images/memorialTest/test_video.mp4');
      _nextItem++;
    }
    notifyListeners();
  }

}