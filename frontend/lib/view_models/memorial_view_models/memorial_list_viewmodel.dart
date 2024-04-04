import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_grave_model.dart';
import 'package:frontend/models/memorial/memorial_search_model.dart';
import 'package:frontend/services/memorial_service.dart';

class MemorialListViewModel extends ChangeNotifier {

  final MemorialService _memorialService = MemorialService();
  List<MemorialGraveModel> _favoriteMemorialList = [];
  List<MemorialGraveModel> _memorialList = [];
  List<MemorialGraveModel> _searchList = [];

  MemorialSearchModel _searchData = MemorialSearchModel(searchWord: '');

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  List<MemorialGraveModel> get favoriteMemorialList => _favoriteMemorialList;
  List<MemorialGraveModel> get memorialList => _memorialList;
  List<MemorialGraveModel> get searchList => _searchList;

  String get searchWord => _searchData.searchWord;

  bool get isFocused => _isFocused;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  MemorialListViewModel() {
    getLists();
    // debugPrint(_memorialList.toString());
    // debugPrint(_favoriteMemorialList.toString());
  }

  // 리스트 조회
  Future<void> getLists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _memorialService.getList();
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
      _favoriteMemorialList = result['favoriteMemorialList'];
      _memorialList = result['memorialList'];
      _searchList = [];
    }
    // debugPrint('$_memorialList');
    _isLoading = false;
    notifyListeners();
  }

  // 즐겨찾기
  Future favoriteMemorial() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _memorialService.favoriteMemorial();
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
      getLists();
    }
  }

  // 검색
  void setSearchWord(String value) {
    _searchData = MemorialSearchModel(searchWord: value);
    notifyListeners();
  }

  void setFocused(bool value) {

    _isFocused = value;
    notifyListeners();
  }

  Future search() async {
    _searchList = [];

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
  
    // 검색
    final result = await _memorialService.searchMemorial(_searchData);
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
      // getLists();
      _searchList = result['searchMemorialList'];
      // debugPrint('$_searchList');
      }
    _isLoading = false;
    notifyListeners();
  }
}
