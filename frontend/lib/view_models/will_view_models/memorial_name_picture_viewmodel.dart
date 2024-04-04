import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/will/additional_model.dart';
import 'package:frontend/models/will/gravename_model.dart';
import 'package:frontend/models/will/memorial_info_model.dart';
import 'package:frontend/models/will/memorial_picture_model.dart';
import 'package:frontend/models/will/usememorial_model.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/services/will_service.dart';

class MemorialNamePictureViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  UseMemorialModel _memorialData = UseMemorialModel(useMemorial: '');
  GraveNameModel _graveData = GraveNameModel(graveName: '');
  final MemorialInfoModel _memorialInfoData = MemorialInfoModel(useMemorial: '', graveName: '');

  MemorialPictureModel _pictureData = MemorialPictureModel(pictureFile: null);

  bool _isFocused = false;
  bool _isLoading = false;
  String? _errorMessage;

  String get useMemorial => _memorialData.useMemorial;

  String? get graveName => _graveData.graveName;

  File? get pictureFile => _pictureData.pictureFile;

  bool get isFocused => _isFocused;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void setGraveName(String value) {
    _graveData =
        GraveNameModel(graveName: value);
    notifyListeners();
  }

  void setFile(File value) {
    _pictureData = MemorialPictureModel(pictureFile: value);
    // debugPrint('$_pictureData');
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  Future<void> setMemorial() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _memorialInfoData.useMemorial = '이용';
    _memorialInfoData.graveName = _graveData.graveName;

    final result = await _willService.memorialInfo(_memorialInfoData);
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
      _errorMessage = null;
    }
    notifyListeners();
  }

  Future<void> setPicture() async {
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.picture(_pictureData.pictureFile!);
    // debugPrint((_recordingData.audioFile).toString());
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
