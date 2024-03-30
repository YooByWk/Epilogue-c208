import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/memorial/memorial_photo_list_model.dart';
import 'package:frontend/models/memorial/memorial_photo_model.dart';
import 'package:frontend/services/memorial_service.dart';

class PhotoTabViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();

  //
  PhotoTabViewModel() {
    // loadInitialData();
    getLists();
  }
//
//   void loadInitialData() {
//     for (int i = 0; i < 20; i++) {
//       _photos.add('assets/images/ameno.jpg');
//     }
//   }

  List<MemorialPhotoListModel> _photos = [];
  // int _nextItem = 0;
  final dio = Dio();

  List<MemorialPhotoListModel> get photos => _photos;

  MemorialPhotoModel _photoData = MemorialPhotoModel(
    photoFile: null,
    content: null,
  );

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  File? get photoFile => _photoData.photoFile;

  String? get content => _photoData.content;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void setFile(File value) {
    _photoData = MemorialPhotoModel(
      photoFile: value,
      content: _photoData.content,
    );
    notifyListeners();
  }

  void setContent(String value) {
    _photoData = MemorialPhotoModel(
      photoFile: _photoData.photoFile,
      content: value,
    );
  }

  // 사진 저장
  Future<void> setPhoto() async {
    _errorMessage = null;
    notifyListeners();

    final result = await _memorialService.photoUpload(
        _photoData.photoFile!, _photoData.content!);
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

  // 사진 리스트 불러오기
  Future<void> getLists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _memorialService.getDetail();
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
      _photos = result['memorialPhotoList'];
      // .map((item) => MemorialGraveModel.fromJson(item))
      // .toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}


//  final baseURL = dotenv.env['API_URL'];
// Future<void> loadMore() async {
//   // 데이터 로드
//   debugPrint('Added item $_nextItem');
//   for (int i = 0; i < 20; i++) {
//     _photos.add('assets/images/ameno.jpg');
//     _nextItem++; // 다음 아이템을 가리키는 인덱스 증가
//   }
//   notifyListeners(); // 데이터가 변경되었음을 알림
// }

// void testAPI() async {
//   // api 실험 호출
//   // String link = 'http://j10c208.p.ssafy.io:8080/api/test';
//
//   var res = await http.get(Uri.parse(baseURL.toString() + '/api/test'));
//
//   if (res.statusCode == 200) {
//     debugPrint('API 호출 성공555555555');
//     debugPrint('API 호출 + $baseURL');
//   } else {
//     debugPrint('API 호출 실패');
//   }
//   // debugPrint('asdasd${res.body.pre?}');
//
//   notifyListeners();
// }
//
// void testAPI4() async {
//   debugPrint('APi 호출 ');
//   Response response2 =
//       await dio.get('http://j10c208.p.ssafy.io:8080/api/test');
//   Response response =
//       await dio.get('http://j10c208.p.ssafy.io:8080/api/memorial/list');
//   debugPrint(response.data.toString());
//   debugPrint(response.statusMessage.toString());
//   debugPrint(response2.data.toString());
//   // print(response2.data.toString());
//   // debugPrint(response.data.toString());
// }