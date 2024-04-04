//memorial_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/memorial/memorial_grave_model.dart';
import 'package:frontend/models/memorial/memorial_letter_list_model.dart';
import 'package:frontend/models/memorial/memorial_photo_detail_model.dart';
import 'package:frontend/models/memorial/memorial_photo_list_model.dart';
import 'package:frontend/models/memorial/memorial_search_model.dart';
import 'package:frontend/models/memorial/memorial_video_detail_model.dart';
import 'package:frontend/models/memorial/memorial_video_list_model.dart';
import 'package:frontend/models/memorial_detail_model.dart';
import 'package:frontend/models/memorial_letter_upload_model.dart';

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
      // debugPrint('리스트 불러오기');
      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = response.data;

        List<MemorialGraveModel> favoriteMemorialList = [];
        if (response.data['favoriteMemorialList'] != null) {
          for (var item in response.data['favoriteMemorialList']) {
            favoriteMemorialList.add(
              MemorialGraveModel.fromJson(item),
            );
          }
        }
        // debugPrint('$favoriteMemorialList');
        List<MemorialGraveModel> memorialList = [];
        if (response.data['memorialList'] != []) {
          for (var item in response.data['memorialList']) {
            memorialList.add(
              MemorialGraveModel.fromJson(item),
            );
          }
        }
        // debugPrint('$memorialList');
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

  ////////////////// 추모관 디테일 ///////////////////////
  Future<Map<String, dynamic>> getDetail() async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');
    try {
      Dio.Response response = await _dio.get(
        baseUrl + '/api/memorial/visit/$memorialSeq',
      );

      // debugPrint('디테일!');
      if (response.statusCode == 200) {
        List<MemorialPhotoListModel> memorialPhotoList = [];
        if (response.data['memorialPhotoList'] != []) {
          for (var item in response.data['memorialPhotoList']) {
            memorialPhotoList.add(
              MemorialPhotoListModel.fromJson(item),
            );
          }
        }

        MemorialDetailModel memorialDetailModel =
        MemorialDetailModel.fromJson(response.data);

        return {
          'success': true,
          'memorialPhotoList': memorialPhotoList,
          'memorialDetailModel': memorialDetailModel,
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 추모관 사진 업로드 ///////////////////////
  Future<Map<String, dynamic>> photoUpload(
      File photoFile, String? content) async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');
    String contentJson = jsonEncode(content);

    var formData = Dio.FormData.fromMap({
      'multipartFile': await Dio.MultipartFile.fromFile(photoFile.path),
      'content': contentJson,
    });

    try {
      // _dio.options.contentType = 'application/json';
      // _dio.options.contentType = 'multipart/form-data';
      Dio.Response response = await _dio.post(
        '$baseUrl/api/memorial/media/$memorialSeq',
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

  ////////////////// 추모관 사진 리스트 ///////////////////////
  Future<Map<String, dynamic>> photoList({required int lastPhotoSeq}) async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');

    try {
      Dio.Response response = await _dio.get(
        '$baseUrl/api/memorial/photo-list/$memorialSeq/$lastPhotoSeq',
      );

      if (response.statusCode == 200) {
        List<MemorialPhotoListModel> photoList = [];
        if (response.data['memorialPhotoDtoList'] != []) {
          for (var item in response.data['memorialPhotoDtoList']) {
            photoList.add(
              MemorialPhotoListModel.fromJson(item),
            );
          }
        }

        String count = response.data['count'].toString();

        return {'success': true, 'photoList': photoList, 'count': count};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 추모관 사진 디테일 ///////////////////////
  Future<Map<String, dynamic>> photoDetail() async {
    String? memorialPhotoSeq = await _storage.read(key: 'photoSeq');

    try {
      Dio.Response response = await _dio.get(
        '$baseUrl/api/memorial/photo/$memorialPhotoSeq',
      );

      if (response.statusCode == 200) {
        MemorialPhotoDetailModel memorialPhotoDetailModel =
        MemorialPhotoDetailModel.fromJson(response.data);

        return {
          'success': true,
          'memorialPhotoDetailModel': memorialPhotoDetailModel
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 사진 신고하기 ///////////////////////
  Future<Map<String, dynamic>> reportPhoto() async {
    String? photoSeq = await _storage.read(key: 'photoSeq');

    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/memorial/report/photo/$photoSeq',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }


////////////////// 추모관 편지 업로드 ///////////////////////
  Future<Map<String, dynamic>> letterUpload(
      LetterUploadModel letterUploadModel) async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');
    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/memorial/letter/$memorialSeq',
        data: letterUploadModel.toJson(),
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

  ////////////////// 추모관 편지 리스트 ///////////////////////
  Future<Map<String, dynamic>> letterList({required int lastLetterSeq}) async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');
    // debugPrint('$lastLetterSeq');
    try {
      Dio.Response response = await _dio.get(
        '$baseUrl/api/memorial/letter-list/$memorialSeq/$lastLetterSeq',
      );

      if (response.statusCode == 200) {
        List<MemorialLetterListModel> letterList = [];
        if (response.data['memorialLetterDtoList'] != []) {
          for (var item in response.data['memorialLetterDtoList']) {
            letterList.add(
              MemorialLetterListModel.fromJson(item),
            );
          }
        }

        String count = response.data['count'].toString();
        // debugPrint(count);
        // debugPrint('$letterList');
        return {'success': true, 'letterList': letterList, 'count': count};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 추모관 영상 업로드 ///////////////////////
  Future<Map<String, dynamic>> videoUpload(
      File videoFile, String? content) async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');
    String contentJson = jsonEncode(content);

    var formData = Dio.FormData.fromMap({
      'multipartFile': await Dio.MultipartFile.fromFile(videoFile.path),
      'content': contentJson,
    });

    try {
      _dio.options.contentType = 'multipart/form-data';
      Dio.Response response = await _dio.post(
        '$baseUrl/api/memorial/media/$memorialSeq',
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

  ////////////////// 추모관 영상 리스트 ///////////////////////
  Future<Map<String, dynamic>> videoList({required int lastVideoSeq}) async {
    String? memorialSeq = await _storage.read(key: 'graveSeq');

    try {
      Dio.Response response = await _dio.get(
        '$baseUrl/api/memorial/video-list/$memorialSeq/$lastVideoSeq',
      );

      if (response.statusCode == 200) {
        List<MemorialVideoListModel> videoList = [];
        if (response.data['memorialVideoDtoList'] != []) {
          for (var item in response.data['memorialVideoDtoList']) {
            videoList.add(
              MemorialVideoListModel.fromJson(item),
            );
          }
        }

        String count = response.data['count'].toString();

        return {'success': true, 'videoList': videoList, 'count': count};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }
  ////////////////// 추모관 영상 디테일 ///////////////////////
  Future<Map<String, dynamic>> videoDetail() async {
    String? memorialVideoSeq = await _storage.read(key: 'videoSeq');

    try {
      Dio.Response response = await _dio.get(
        '$baseUrl/api/memorial/video/$memorialVideoSeq',
      );

      if (response.statusCode == 200) {
        MemorialVideoDetailModel memorialVideoDetailModel =
        MemorialVideoDetailModel.fromJson(response.data);

        return {
          'success': true,
          'memorialVideoDetailModel': memorialVideoDetailModel
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 영상 신고하기 ///////////////////////
  Future<Map<String, dynamic>> reportVideo() async {
    String? videoSeq = await _storage.read(key: 'videoSeq');

    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/memorial/report/video/$videoSeq',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 추모관 즐겨찾기 ///////////////////////
  Future<Map<String, dynamic>> favoriteMemorial() async {
    String? memorialSeq = await _storage.read(key: 'favoriteMemorial');

    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/memorial/favorite/$memorialSeq',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
        };
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////// 추모관 검색 ///////////////////////
  Future<Map<String, dynamic>> searchMemorial(MemorialSearchModel memorialSearchModel) async {

    try {
      Dio.Response response = await _dio.post(
          '$baseUrl/api/memorial/search',
          data: memorialSearchModel.toJson()
      );

      if (response.statusCode == 200) {

        List<MemorialGraveModel> searchMemorialList = [];
        if (response.data != null) {
          for (var item in response.data) {
            searchMemorialList.add(
              MemorialGraveModel.fromJson(item),
            );
          }
        }
        return {
          'success': true, 'searchMemorialList':searchMemorialList,
        };
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