import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:frontend/models/login_model.dart';
import 'package:frontend/models/signup_model.dart';
import 'package:flutter/material.dart';

class AuthService {
  final Dio _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = 'http://j10c208.p.ssafy.io:8080';

  AuthService() {
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
  }

  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    try {
      Response response =
          await _dio.post(baseUrl + '/login', data: loginModel.toJson());

      if (response.statusCode == 200) {
        String token = response.data['Authorization'];
        await _storage.write(key: 'token', value: token);
        return {'success': true, 'message': '로그인 성공'};
      } else {
        return {'success': false, 'message': '로그인 실패', 'statusCode': response.statusCode};
      }
    } on DioError catch (e) {
      return {'success': false, 'message': e.message, 'statusCode': e.response?.statusCode};
    }
  }

  Future<bool> signup(SignupModel signupModel) async {
    try {
      Response response = await _dio.post(baseUrl + '/api/user/join',
          data: signupModel.toJson());

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    super.onError(err, handler);
  }
}
