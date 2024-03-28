// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:dio/dio.dart' as Dio;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter/material.dart';
//
// class MemorialService {
//   final _dio = Dio.Dio();
//   final _storage = FlutterSecureStorage();
//   final baseUrl = dotenv.env['API_URL'] ?? '';
//
//   MemorialService() {
//     _dio.interceptors.add(Dio.InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         // 저장된 토큰을 가져온다
//         String? token = await _storage.read(key: 'token');
//         if (token != null) {
//           // 요청 헤더에 토큰을 추가한다
//           options.headers['Access_Token'] = token;
//         }
//         return handler.next(options); // 요청을 계속 진행한다
//       },
//     ));
//     _dio.interceptors.add(LoggingInterceptor()); // console에 로깅
//   }
//
//   ////////////////// 추모관 리스트 (메인 추모관) ///////////////////////
// Future<Map<String, dynamic>> memorialList()
//
//   class LoggingInterceptor extends Dio.Interceptor {
//   @override
//   void onRequest(
//   Dio.RequestOptions options, Dio.RequestInterceptorHandler handler) {
//   debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
//   super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(
//   Dio.Response response, Dio.ResponseInterceptorHandler handler) {
//   debugPrint(
//   "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
//   super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(Dio.DioError err, Dio.ErrorInterceptorHandler handler) {
//   debugPrint(
//   "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
//   super.onError(err, handler);
//   }
// }