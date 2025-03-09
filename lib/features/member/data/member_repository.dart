import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/providers.dart';
import '../../../core/type_defs.dart';
import '../../../core/utils/utils.dart';
import '../domain/member_model.dart';

part 'member_repository.g.dart';

@riverpod
MemberRepository memberRepository(Ref ref) {
  return MemberRepository(
    dioClient: ref.watch(dioProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
}

class MemberRepository {
  final Dio _dioClient;
  final FlutterSecureStorage _secureStorage;

  MemberRepository({
    required Dio dioClient,
    required FlutterSecureStorage secureStorage,
  }) : _dioClient = dioClient,
       _secureStorage = secureStorage;

  FutureEither<List<MemberModel>> fetchMembers() async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllMembers,
      );
      lgr.i('fetching members from: ${uri.toString()}');
      final token = await _secureStorage.read(key: 'token');
      lgr.e('token: $token');
      final response = await _dioClient.get(
        uri.toString(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      lgr.i('got response: $response');

      if (response.statusCode == 200) {
        lgr.i('statusCode: 200 : ${response.data}');
        final List<dynamic> memberList = response.data['data'];
        final List<MemberModel> members =
            memberList.map((e) => MemberModel.fromJson(e)).toList();
        return right(members);
      } else {
        return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
      }
    } on DioException catch (err) {
      if (err.response != null && err.response!.statusCode == 401) {
        lgr.w(
          '${err.response!.statusCode} ${err.response!.statusMessage}\n${err.response!.data}',
        );
      }
      return left(Failure('You are not authorized to view this content'));
    } catch (err) {
      lgr.e('Error: $err');
      return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
    }
  }
}
