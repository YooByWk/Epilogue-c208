import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_grave_model.dart';
import 'package:frontend/services/memorial_service.dart';

class MemorialListViewModel extends ChangeNotifier {
  // int _nextItem = 0;

  // void loadMore() {
  //   // Add more items to the list
  //     debugPrint('Added item $_nextItem');
  //   for (int i = 0; i < 20; i++) {
  //     _memorialCards.add('assets/images/ameno.jpg');
  //     _nextItem++;
  //   }
  //   notifyListeners(); // Notify listeners to update the UI
  // }
  final MemorialService _memorialService = MemorialService();
  List<MemorialGraveModel> _favoriteMemorialList = [];
  List<MemorialGraveModel> _memorialList = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<MemorialGraveModel> get favoriteMemorialList => _favoriteMemorialList;

  List<MemorialGraveModel> get memorialList => _memorialList;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

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
          // .map((item) => MemorialGraveModel.fromJson(item))
          // .toList();
      _memorialList = result['memorialList'];
          // .map((item) => MemorialGraveModel.fromJson(item))
          // .toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}
