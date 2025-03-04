import 'package:bjp_app/features/auth/domain/login_response_model.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dioClient;

  AuthRepository({required Dio dioClient}) : _dioClient = dioClient;

  Future<LoginResponseModel?> loginUser() async{
    try {
      final response = await _dioClient.post('login');
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }

    return null;
  }
}
