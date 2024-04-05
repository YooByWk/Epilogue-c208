import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:frontend/models/will/my_will_model.dart';
import 'package:frontend/services/will_service.dart';
import 'package:frontend/view_models/block_chain/block_chain_will_viewmodel.dart';
import 'package:path_provider/path_provider.dart';


class MyWillViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  final BlockChainWillViewModel _blockChainWillViewModel = BlockChainWillViewModel();
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

  Map<String, dynamic> get willData => {
        'sustainCare': sustainCare,
        'funeralType': funeralType,
        'graveType': graveType,
        'organDonation': organDonation,
        'useMemorial': useMemorial,
        'graveName': graveName,
        'graveImageAddress': graveImageAddress,
        'willFileAddress': willFileAddress,
      };

  Future<void> initialize() async {
    await normalfetchData();
    debugPrint('실행중이니?');
    debugPrint(_willModel.graveName?.toString() ?? 'null');
    debugPrint('여기 ${willData['graveName'].toString()}');
  }


  Future normalfetchData() async {
    _willModel = await _willService.getWillInfo();
    notifyListeners();
    debugPrint(willData['graveName'].toString());
    debugPrint('왜 다운 안하냐?');

    try {
      Directory cacheDir = await getTemporaryDirectory();
      await _dio.download(_willModel.willFileAddress!, '${cacheDir.path}/downloadedwill.mp4');
      debugPrint('다운로드 하고있어요....');
      File('${cacheDir.path}/downloadedwill.mp4').exists().then((value) => debugPrint('파일이 있나요? $value'));
    } catch (e) {
      debugPrint('다운로드 실패: $e');
    } 
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

  Future fixS3 () async {
    // 유저 주소로 유언 가져옴
    var ipfsHash = await _blockChainWillViewModel.MyWill();
    _willService.ipfsUpload(ipfsHash[3]);
    debugPrint(ipfsHash[3]);
  }
}
