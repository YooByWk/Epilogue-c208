import 'package:flutter/material.dart'; //debugPrint 사용 위함
import 'package:dio/dio.dart'; // Dio 사용 위함 

// Dio는 HTTP 클라이언트로서, Dart 언어로 작성된 비동기 HTTP 클라이언트 프레임워크.

class DioExamples {
final dio = Dio(); // 
void GetRequest() async {
  Response response = await dio.get('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void PostRequest() async {
  Response response = await dio.post('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void PutRequest() async {
  Response response = await dio.put('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void DeleteRequest() async {
  Response response = await dio.delete('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void DownloadRequest() async {
  Response response = await dio.download('http://j10c208.p.ssafy.io:8080/api/test', 'downloadPath');
  debugPrint(response.data.toString());
}
// 대충 이런식으로 사용하면 됩니다.

/* Dio의 Response 구성
final response = await dio.get('https://pub.dev');
print(response.data);
print(response.headers);
print(response.requestOptions);
print(response.statusCode);
*/

// dio의 주요 메서드
// get, post, put, delete, download, head, patch, request
// 이 중에서 get, post, put, delete, download를 사용하면 됩니다.
// https://pub.dev/packages/dio 참고
}

// 