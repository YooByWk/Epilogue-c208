import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/will/additional_model.dart';
import 'package:frontend/models/will/memorial_info_model.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/models/will/witness_model.dart';
import 'package:frontend/models/will/my_will_model.dart';
import 'package:path_provider/path_provider.dart';

class WillService {


  final _dio = Dio.Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.env['API_URL'] ?? '';
  final ipfsUrl = dotenv.env['IPFS_URL'] ?? '';
  
  WillService() {
    
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

  // 실험 //
  Future<MyWillModel> getWillInfo() async {
    try {
      Dio.Response res = await _dio.get('$baseUrl/api/myWill');
      debugPrint(res.toString());
      MyWillModel willInfo = MyWillModel.fromJson(res.data);
      debugPrint(willInfo.willFileAddress.toString());
      return willInfo;
    } catch (e) {
      debugPrint('아오');
      throw Exception(e);
    }
  }

  ///////////////////////// 열람인 //////////////////////////////////
  Future<Map<String, dynamic>> sendViewer(List<ViewerModel> viewerList) async {
    var viewers = viewerList.map((data) => data.toJson()).toList();
    // debugPrint('$viewers');
    try {
      Dio.Response response =
          await _dio.post(baseUrl + '/api/will/viewer', data: viewers);
      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

///////////////////////// 선택사항 //////////////////////////////////
  Future<Map<String, dynamic>> additionalInfo(
      AdditionalModel additionalModel) async {
    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/will/additional',
        data: additionalModel.toJson(),
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

  
  /// ipfs 업로드
  Future ipfsUpload(String ipfsHash) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '$tempPath/will.mp4';
    await _dio.download(ipfsUrl +'5001/ipfs/${ipfsHash}', filePath);
    var file = File(filePath);
    debugPrint(file.path);
    var formData = Dio.FormData.fromMap({
      'multipartFile': await Dio.MultipartFile.fromFile(file.path),
    });

    try {
      Dio.Response response = await _dio.post(
        baseUrl + '/api/will',
        data: formData,
      );

      if (response.statusCode == 200) {
        return {'success': true, 'ipfsHash': response.data['ipfsHash']};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }
///////////////////////// 녹음 저장 //////////////////////////////////
  Future<Map<String, dynamic>> recording(File audioFile) async {
    var formData = Dio.FormData.fromMap({
      'multipartFile': await Dio.MultipartFile.fromFile(audioFile.path,
          filename: 'will.mp4'),
    });
    // debugPrint(formData.toString());
    // debugPrint(audioFile.toString());
    try {
      // _dio.options.contentType = 'multipart/form-data';
      Dio.Response response =
      await _dio.post(baseUrl + '/api/will',
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

  ///////////////////////// 증인 //////////////////////////////////
  Future<Map<String, dynamic>> sendWitness(
      List<WitnessModel> witnessList) async {
    var witnesses = witnessList.map((data) => data.toJson()).toList();
    try {
      Dio.Response response =
          await _dio.post(baseUrl + '/api/will/witness', data: witnesses);
      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

///////////////////////// 추모관 정보 //////////////////////////////////
  Future<Map<String, dynamic>> memorialInfo(
      MemorialInfoModel memorialInfoModel) async {
    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/will/memorialAndGraveName',
        data: memorialInfoModel.toJson(),
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

  ///////////////////////// 추모관 사진 저장 //////////////////////////////////
  Future<Map<String, dynamic>> picture(File pictureFile) async {
    var formData = Dio.FormData.fromMap({
      'multipartFile': await Dio.MultipartFile.fromFile(pictureFile.path),
    });

    try {
      _dio.options.contentType = 'multipart/form-data';
      Dio.Response response = await _dio.post(
        baseUrl + '/api/will/graveImage',
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

  //////////////////////// 유언 열람(열람인) ///////////////////////
  Future<Map<String, dynamic>> willOpen(String? willCode) async {

    var formData = Dio.FormData.fromMap({
      'willCode': willCode,
    });

    try {
      Dio.Response response = await _dio.post(
        '$baseUrl/api/will/certificate',
        data: formData,
      );

      if (response.statusCode == 200) {
        var willFileAddress = response.data['willFileAddress'];
        return {'success': true, 'willFileAddress': willFileAddress};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioException catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }
}

class LoggingInterceptor extends Dio.Interceptor {
  @override
  void onRequest(
      Dio.RequestOptions options, Dio.RequestInterceptorHandler handler) {
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
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
