import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:frontend/models/will/my_will_model.dart';
import 'package:frontend/services/will_service.dart';
import 'package:path_provider/path_provider.dart';

class MyWillViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  MyWillModel _willModel = MyWillModel();
  final _dio = Dio.Dio();
  String? get sustainCare => _willModel.sustainCare;
  String? get funeralType => _willModel.funeralType;
  String? get graveType => _willModel.graveType;
  String? get organDonation => _willModel.organDonation;
  String? get useMemorial => _willModel.useMemorial;
  String? get graveName => _willModel.graveName;
  String? get graveImageAddress => _willModel.graveImageAddress;
  String? get willFileAddress => _willModel.willFileAddress;

  Future<void> initialize() async {
    await normalfetchData();
    debugPrint('실행중이니?');
    debugPrint(_willModel.graveName?.toString() ?? 'null');
  }


  Future normalfetchData() async {
    _willModel = await _willService.getWillInfo();
    notifyListeners();
    return '200';
  }

  Future<void> fetchMyWillData() async {
    // 모델에 데이터를 넣음
    final directory = await getApplicationCacheDirectory();
    final path = '${directory.path}/downloadedwill.mp4';
    _willModel = await _willService.getWillInfo();
    debugPrint('실행중이니?');
    // 파일을 다운로드 받아서 저장
    try {
      await _dio.download(_willModel.willFileAddress!, path);
      debugPrint('다운로드 완료 $path');
    } catch (e) {
      debugPrint('다운로드 실패: $e');
    }
    // 데이터가 바뀌었다는 것을 알림
    notifyListeners();
  }
}
