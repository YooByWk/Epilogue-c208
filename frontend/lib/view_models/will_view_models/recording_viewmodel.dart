import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/will/recording_model.dart';
import 'package:frontend/services/will_service.dart';

class RecordingViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
   RecordingModel _recordingData = RecordingModel(audioFile: null);
  String? _errorMessage;

  File? get audioFile => _recordingData.audioFile;
  String? get errorMessage => _errorMessage;

  // RecordingViewModel({required File audioFile}) {
  //   _recordingModel = RecordingModel(audioFile: audioFile);
  // }

  void setFile(File value) {
    _recordingData = RecordingModel(audioFile: value);
    notifyListeners();
  }

  Future<void> setRecording() async {
    _errorMessage = null;
    notifyListeners();

    final result = await _willService.recording(_recordingData.audioFile!);
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
