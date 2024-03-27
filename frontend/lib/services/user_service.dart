import 'package:dio/dio.dart';
import 'package:frontend/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  Dio _dio = Dio();
  final baseUrl = dotenv.env['API_URL'] ?? '';

  Future<UserModel> fetchUserData() async {
    try {
      Response response = await _dio.get('$baseUrl/api/user');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('정보를 불러오는 데 실패했습니다.');
    }
  }

}