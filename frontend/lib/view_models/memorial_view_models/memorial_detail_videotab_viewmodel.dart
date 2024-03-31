import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_video_list_model.dart';
import 'package:frontend/services/memorial_service.dart';
import 'package:provider/provider.dart'; 
import 'package:video_player/video_player.dart'; 

class VideoTabViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();
  
  List<MemorialVideoListModel> _videos = [];
  int _nextItem = 0 ;
  int _focusedIndex = 0;
  bool _isLoading = false;
  ScrollController scrollController = ScrollController();

  List<MemorialVideoListModel> get videos => _videos;
  int get focusedIndex => _focusedIndex;

  VideoTabViewModel() {
    loadInitialData();
  }


  bool _isFocused = false;
  String? _errorMessage;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void loadInitialData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lastVideoSeq = _videos.isNotEmpty ? _videos.last.memorialVideoSeq : 0;
    final result = await _memorialService.videoList(lastVideoSeq: lastVideoSeq);
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
      _videos = result['videoList'];
      _isLoading = false;
    }
    notifyListeners(); // 데이터가 변경되었음을 알림
  }

  Future<void> loadMore() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lastVideoSeq = _videos.isNotEmpty ? _videos.last.memorialVideoSeq : 0;
    final result = await _memorialService.videoList(lastVideoSeq: lastVideoSeq);

    //전체 다 불러왔으면 그만!
    if (_videos.length.toString() == result['count']) {
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
      _videos.addAll(result['videoList']);
      _isLoading = false;
    }
    notifyListeners();
  }

}