import 'dart:convert';

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
import '../domain/register_input_model.dart';

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
    required String mobileOrEmail,
    required String password,
    required bool isAdmin,
  }) async {
    lgr.i('Login request sending..: ');
    try {
      //'http://116.68.206.157:9445/api/login',
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: isAdmin ? ApiConstants.adminLogin : ApiConstants.login,
      );
      lgr.i('Login request sending to: ${uri.toString()}');
      final response = await _dioClient.post(
        uri.toString(),
        data:
            isAdmin
                ? {'email': mobileOrEmail, 'password': password}
                : {'phone_number': mobileOrEmail, 'password': password},
      );

      lgr.i('Login response received: ${response.data}');

      final loginResponse = LoginResponseModel.fromJson(response.data);
      if (response.statusCode == 200) {
        lgr.i('Token received: ${loginResponse.token}');
        await _saveUser(loginResponse);
        _authStateController.value = loginResponse;
        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
    // return null;
  }

  Future<void> register({required RegisterInputModel data}) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.register,
      );

      lgr.i('Register request sending to: ${uri.toString()}');

      final response = await _dioClient.post(
        uri.toString(),
        data: data.toJson(),
      );

      // await _saveToken(response.data['token']);
    } catch (err) {}
  }

  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: 'token');
      await _secureStorage.delete(key: 'user');
      _authStateController.value = null;
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  Future<String?> getUser() async {
    return await _secureStorage.read(key: 'user');
  }

  Future<void> _saveUser(LoginResponseModel response) async {
    await _secureStorage.write(key: 'token', value: response.token);
    await _secureStorage.write(
      key: 'user',
      value: jsonEncode(response.user?.toJson()),
    );
  }
}
