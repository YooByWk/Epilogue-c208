import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 

class VideoTabViewModel extends ChangeNotifier {
  List<String> _videos = [];
  int _nextItem = 0 ;
  int _focusedIndex = 0;
  bool _isLoading = false;


  List<String> get videos => _videos;
  int get focusedIndex => _focusedIndex;

  VideoTabViewModel() {
    loadInitialData();
  }


  // // 초점 확인
  // set focusedIndex(int index) {
  //   if (_focusedIndex != index) {
  //      _focusedIndex = index;
  //       ValueNotifier<int>(_focusedIndex);
  //   }
  // }



  void loadInitialData() {
    for (int i = 0; i < 10; i++) {
      _videos.add('assets/images/memorialTest/test_video.mp4');
      _nextItem++;
    }
      debugPrint('초기 데이터 추가 : 추모관 비디오 탭');
      debugPrint('비디오 리스트 : $_videos');
      debugPrint('주소 : ${_videos[0]}');
  }

  Future<void> loadMore() async {
    if (_isLoading) {
      return;
    }
    // 비디오 로드
    _isLoading = true;


    
    for (int i =0; i < 10; i++) {
      _videos.add('assets/images/memorialTest/test_video.mp4');
      _nextItem++;
    }
    _isLoading = false; 
    notifyListeners();
  }

}