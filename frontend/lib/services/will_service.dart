import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/will/additional_model.dart';
import 'package:frontend/models/will/viewer_model.dart';
import 'package:frontend/view_models/will_view_models/viewer_viewmodel.dart';


class WillService {
  final Dio _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.env['API_URL'] ?? '';

  WillService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 저장된 토큰을 가져온다
        String? token = await _storage.read(key: 'token');
        if (token != null) {
          // 요청 헤더에 토큰을 추가한다
          options.headers['Authorization'] = token;
        }
        return handler.next(options); // 요청을 계속 진행한다
      },
    ));
    _dio.interceptors.add(LoggingInterceptor()); // console에 로깅
  }

  ///////////////////////// 열람인 //////////////////////////////////
  Future<Map<String, dynamic>> sendViewer(List<ViewerModel> viewerList) async {
    final viewers = viewerList.map((data) => data.toJson()).toList();
    debugPrint('$viewers');
    try {
      Response response = await _dio.post(baseUrl + '/api/will/viewer',
          data: viewers);
      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

///////////////////////// 선택사항 //////////////////////////////////
  Future<Map<String, dynamic>> additionalInfo(AdditionalModel additionalModel) async {

    try {
      Response response =
      await _dio.post(baseUrl + '/api/will/additional',
          data: additionalModel.toJson());

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    super.onError(err, handler);
  }
}
