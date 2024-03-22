import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


class PhotoTabViewModel extends ChangeNotifier {
  List<String> _photos = [];
  int _nextItem = 0;
  final dio = Dio();
  List<String> get photos => _photos;

  PhotoTabViewModel() {
    loadInitialData();
  }
  
  void loadInitialData() {
    for (int i = 0; i < 20; i++) {
      _photos.add('assets/images/ameno.jpg');
      _nextItem++;
    }
  }

  Future<void> loadMore() async {
    // 데이터 로드
    debugPrint('Added item $_nextItem');
    for (int i = 0; i < 20; i++) {
      _photos.add('assets/images/ameno.jpg');
      _nextItem++;  // 다음 아이템을 가리키는 인덱스 증가
    }
    notifyListeners();  // 데이터가 변경되었음을 알림
  }

  void testAPI() async {
    // api 실험 호출
    String link = 'http://j10c208.p.ssafy.io:8080/api/test';
    // String link = 'http://j10c208.p.ssafy.io:8080/api/memorial/list';
    debugPrint('API 호출 + $link');

    var res = await http.get(Uri.parse(link));
    debugPrint(res.statusCode.toString());
    if (res.statusCode == 200) {
      debugPrint('API 호출 성공');
    } else {
      debugPrint('API 호출 실패');
    }
    // debugPrint('asdasd${res.body.pre?}');

    notifyListeners();
  }
  
  void testAPI4() async {
    debugPrint('APi 호출 ');
    Response response2 = await dio.get('http://j10c208.p.ssafy.io:8080/api/test'); 
    Response response = await dio.get('http://j10c208.p.ssafy.io:8080/api/memorial/list');
    debugPrint(response.data.toString());
    debugPrint(response.statusMessage.toString());
    debugPrint(response2.data.toString());
    // print(response2.data.toString());
    // debugPrint(response.data.toString());
  }

}
