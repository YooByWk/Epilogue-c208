import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:frontend/models/login_model.dart';
import 'package:frontend/models/signup_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class AuthService {
  final _dio = Dio.Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.env['API_URL'] ?? '';

  AuthService() {
    _dio.interceptors.add(Dio.InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 저장된 토큰을 가져온다
        String? token = await _storage.read(key: 'token');
        if (token != null) {
          // 요청 헤더에 토큰을 추가한다
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options); // 요청을 계속 진행한다
      },
    ));
    _dio.interceptors.add(LoggingInterceptor()); // console에 로깅
  }

  ///////////////////////// 로그인 //////////////////////////////////
  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    try {
      Dio.Response response = await _dio.post('$baseUrl/login',
          options: Dio.Options(
            contentType: Dio.Headers.formUrlEncodedContentType,
          ),
          queryParameters: loginModel.toJson());

      if (response.statusCode == 200) {
        String? token = response.headers.value('Access_Token');
        await _storage.write(key: 'token', value: token);
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ////////////////////////// 토큰 삭제 /////////////////////////////////
  Future<void> delToken() async {
    await _storage.delete(key: 'token');
  }

  //////////////////////////// 회원가입 ///////////////////////////////
  Future<Map<String, dynamic>> signup(SignupModel signupModel) async {
    try {
      Dio.Response response =
          await _dio.post('$baseUrl/api/user/join', data: signupModel.toJson());

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioError catch (e) {
      print(e);
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

/////////////////////// 아이디 중복체크 ////////////////////////////////
  Future<bool> checkUserId(String userId) async {
    try {
      Dio.Response response = await _dio
          .post('$baseUrl/api/user/id/check', data: {'userId': userId});

      debugPrint('아이디 중복 체크!!');
      return response.data; // true면 중복 없음, false면 중복 있음
    } on Dio.DioError catch (e) {
      debugPrint(e.toString());
      return false;
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
