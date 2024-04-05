import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/services/auth_service.dart';

class UserService {
  final _dio = Dio.Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = dotenv.env['API_URL'] ?? '';

  UserService() {
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

  // 유저 정보 가져오기
  Future<UserModel> fetchUserData() async {
    try {
      Dio.Response response = await _dio.get('$baseUrl/api/user');
      UserModel user = UserModel.fromJson(response.data);

      // 유저 정보 로컬에 저장
      String userJson = json.encode(user.toJson());
      await _storage.write(key: 'userInfo', value: userJson);
      return user;
    } catch (e) {
      throw Exception('정보를 불러오는 데 실패했습니다.');
    }
  }

  // 정보 수정
  Future<UserModel?> modifyUserData(String name, String mobile) async {
    try {
      Dio.Response response = await _dio.put(
        '$baseUrl/api/user',
        data: {
          'name': name,
          'mobile': mobile,
        },
      );
      UserModel userData = UserModel.fromJson(response.data);
      return userData;
    } on Dio.DioException catch (e) {
      print(e);
    }
    return null;
  }
}
