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
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<bool> login(LoginModel loginModel) async {
    try {
      Response response = await _dio.post(
          baseUrl + '/login',
          data: loginModel.toJson());

      if (response.statusCode == 200) {
        String token = response.data['token'];
        await _storage.write(key: 'token', value: token);
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signup(SignupModel signupModel) async {
    try {
      Response response = await _dio.post(
        baseUrl + '/api/user/join',
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
