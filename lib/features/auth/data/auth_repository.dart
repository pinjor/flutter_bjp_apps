import 'package:bjp_app/core/utils/utils.dart';
import 'package:bjp_app/features/auth/domain/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/utils/in_memory_store.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    dioClient: ref.watch(dioProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
}

class AuthRepository {
  final Dio _dioClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({
    required Dio dioClient,
    required FlutterSecureStorage secureStorage,
  }) : _dioClient = dioClient,
       _secureStorage = secureStorage;

  final _authStateController = InMemoryStore<LoginResponseModel?>(null);

  // setter for authstatecontroller
  set setAuthStateController(LoginResponseModel? value) =>
      _authStateController.value = value;
  Stream<LoginResponseModel?> get authStateChanges =>
      _authStateController.stream;
  LoginResponseModel? get currentUser => _authStateController.value;

  Future<LoginResponseModel?> login({
    required String mobile,
    required String password,
  }) async {
    lgr.i('Login request sending..: ');
    try {
      //'http://116.68.206.157:9445/api/login',
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.login,
      );
      lgr.i('Login request sending to: ${uri.toString()}');
      final response = await _dioClient.post(
        uri.toString(),
        data: {'phone_number': mobile, 'password': password},
      );

      lgr.i('Login response received: ${response.data}');

      final loginResponse = LoginResponseModel.fromJson(response.data);
      if (loginResponse.token != null) {
        lgr.i('Token received: ${loginResponse.token}');
        await _saveToken(loginResponse.token!);
        _authStateController.value = loginResponse;
      }
      return loginResponse;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: 'token');
      _authStateController.value = null;
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }
}
