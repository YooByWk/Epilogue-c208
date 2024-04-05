import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/memorial/memorial_photo_list_model.dart';
import 'package:frontend/models/memorial/memorial_photo_detail_model.dart';
import 'package:frontend/models/memorial/memorial_photo_upload_model.dart';
import 'package:frontend/services/memorial_service.dart';

class PhotoTabViewModel extends ChangeNotifier {
  final MemorialService _memorialService = MemorialService();

  //
  PhotoTabViewModel() {
    loadInitialData();
  }

  List<MemorialPhotoListModel> _photos = [];
  final dio = Dio();

  List<MemorialPhotoListModel> get photos => _photos;

  MemorialPhotoUploadModel _photoData = MemorialPhotoUploadModel(
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


  void loadInitialData() async {
    _photos = [];
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lastPhotoSeq = _photos.isNotEmpty ? _photos.last.memorialPhotoSeq : 0;
    final result = await _memorialService.photoList(lastPhotoSeq: lastPhotoSeq);
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
      _photos = result['photoList'];
      _isLoading = false;
    }
    notifyListeners(); // 데이터가 변경되었음을 알림
  }

  Future<void> loadMore() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final lastPhotoSeq = _photos.isNotEmpty ? _photos.last.memorialPhotoSeq : 0;
    final result = await _memorialService.photoList(lastPhotoSeq: lastPhotoSeq);

    //전체 다 불러왔으면 그만!
    if (_photos.length.toString() == result['count']) {
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
      _photos.addAll(result['photoList']);
      _isLoading = false;
    }
    notifyListeners();
  }


  void setFile(File value) {
    _photoData = MemorialPhotoUploadModel(
      photoFile: value,
      content: _photoData.content,
    );
    notifyListeners();
  }

  void setContent(String value) {
    _photoData = MemorialPhotoUploadModel(
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
}