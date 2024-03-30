import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_grave_model.dart';

class MemorialService {
  final _dio = Dio.Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.env['API_URL'] ?? '';

  MemorialService() {
    _dio.interceptors.add(Dio.InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 저장된 토큰을 가져온다
        String? token = await _storage.read(key: 'token');
        if (token != null) {
          // 요청 헤더에 토큰을 추가한다
          options.headers['Access_Token'] = token;
        }
        return handler.next(options); // 요청을 계속 진행한다
      },
    ));
    _dio.interceptors.add(LoggingInterceptor()); // console에 로깅
  }

  ////////////////// 추모관 리스트 ///////////////////////
  Future<Map<String, dynamic>> getList() async {
    try {
      Dio.Response response = await _dio.get(
        baseUrl + '/api/memorial/list',
      );
      debugPrint('리스트 불러오기');
      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = response.data;

        List<MemorialGraveModel> favoriteMemorialList = [];
        if (response.data['favoriteMemorialList'] != []) {
          for (var item in response.data['favoriteMemorialList']) {
            favoriteMemorialList.add(
              MemorialGraveModel.fromJson(item),
            );
          }
        }
        debugPrint('$favoriteMemorialList');
        List<MemorialGraveModel> memorialList = [];
        if (response.data['memorialList'] != []) {
          for (var item in response.data['memorialList']) {
            memorialList.add(
              MemorialGraveModel.fromJson(item),
            );
          }
        }
        debugPrint('$memorialList');
        // debugPrint(response.data);

        return {
          'success': true,
          'favoriteMemorialList': favoriteMemorialList,
          'memorialList': memorialList,
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 추모관 사진 업로드 ///////////////////////
  Future<Map<String, dynamic>> photo(
      File photoFile, String? content, int memorialSeq) async {
    String contentJson = jsonEncode(content);

    var formData = Dio.FormData.fromMap({
      'multipartFile': await Dio.MultipartFile.fromFile(photoFile.path),
      'memorialMediaRequestDto': contentJson,
    });

    try {
      _dio.options.contentType = 'multipart/form-data';
      Dio.Response response = await _dio.post(
        baseUrl + '/api/memorial/media/${memorialSeq}',
        data: formData,
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }
}

class LoggingInterceptor extends Dio.Interceptor {
  @override
  void onRequest(
      Dio.RequestOptions options, Dio.RequestInterceptorHandler handler) {
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
    debugPrint("Request Header: ${options.headers}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Dio.Response response, Dio.ResponseInterceptorHandler handler) {
    debugPrint(
        "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    super.onResponse(response, handler);
  }

  @override
  void onError(Dio.DioError err, Dio.ErrorInterceptorHandler handler) {
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    super.onError(err, handler);
  }
}
