import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:frontend/models/user/login_model.dart';
import 'package:frontend/models/user/signup_model.dart';
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
          options.headers['Access_Token'] = token;
        }
        return handler.next(options); // 요청을 계속 진행한다
      },
    ));
    _dio.interceptors.add(LoggingInterceptor()); // console에 로깅
  }

  ///////////////////////// 로그인 //////////////////////////////////
  Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    try {
      Dio.Response response = await _dio.post('$baseUrl/api/login',
          options: Dio.Options(
            contentType: Dio.Headers.formUrlEncodedContentType,
          ),
          data: loginModel.toJson());

      if (response.statusCode == 200) {
        String? token = response.headers.value('Access_Token');
        debugPrint('토큰값: $token');

        if (token != null) {
          await _storage.delete(key: 'token'); // 기존 토큰 삭제
          await _storage.write(key: 'token', value: token);
          return {'success': true};
        } else {
          return {'success': false};
        }
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioException catch (e) {
      debugPrint(e.message);
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

  ///////////////////////// 로그아웃 /////////////////////////////////
  Future<void> logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'userInfo');
  }

  //////////////////////////// 회원가입 ///////////////////////////////
  Future<Map<String, dynamic>> signup(SignupModel signupModel) async {
    try {
      Dio.Response response =
          await _dio.post('$baseUrl/api/user/join', data: signupModel.toJson());

      ////////////// 회원가입 요청 성공 BC ///////////////////
      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {'success': false, 'statusCode': response.statusCode};
      }
    } on Dio.DioException catch (e) {
      print(e);
      return {'success': false, 'statusCode': e.response?.statusCode};
    }
  }

/////////////////////// 아이디 중복체크 ////////////////////////////////
  Future<bool> checkUserId(String userId) async {
    try {
      Dio.Response response = await _dio
          .post('$baseUrl/api/user/id/check', data: {'userId': userId});
      debugPrint(response.data.toString());
      return response.data; // true면 중복 있음, false면 중복 없음
    } on Dio.DioException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

/////////////////// 휴대폰 인증 ///////////////////////////////
  Future<void> mobileCertificationSend(String mobile) async {
    try {
      Dio.Response response = await _dio
          .post('$baseUrl/api/sms-certification/send', data: {'phone': mobile});
    } on Dio.DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> mobileCertificationConfirm(
      String mobile, String certificationNumber) async {
    try {
      Dio.Response response =
          await _dio.post('$baseUrl/api/sms-certification/confirm', data: {
        'phone': mobile,
        'certificationNumber': certificationNumber,
      });
      return response.data; // true면 인증 성공
    } catch (e) {
      print(e);
      return false;
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
