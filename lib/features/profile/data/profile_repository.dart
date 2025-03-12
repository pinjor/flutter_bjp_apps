import 'package:bjp_app/core/type_defs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/providers.dart';
import '../../../core/utils/utils.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(
    dioClient: ref.watch(dioProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
}

class ProfileRepository {
  final Dio _dioClient;

  final FlutterSecureStorage _secureStorage;

  ProfileRepository({
    required Dio dioClient,
    required FlutterSecureStorage secureStorage,
  }) : _dioClient = dioClient,
       _secureStorage = secureStorage;

  FutureEitherVoid updateProfile({required String userName}) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.updateProfile,
      );
      final token = await _secureStorage.read(key: 'token');
      lgr.w('got token: $token');
      final result = await _dioClient.post(
        uri.toString(),
        data: {'name': userName},

        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      lgr.i('got response: $result');

      if (result.statusCode == 200) {
        lgr.i('statusCode: 200 : ${result.data}');
        
        return right(null);
      } else {
        lgr.f('statusCode: ${result.statusCode} : ${result.data}');
        return left(Failure('Failed to update profile'));
      }
    } catch (err) {
      lgr.e('error: $err');
      return left(Failure('Failed to update profile'));
    }
  }
}
