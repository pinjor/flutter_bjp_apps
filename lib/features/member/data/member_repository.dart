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
      lgr.i('got token: $token');
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
            memberList
                .map(
                  (member) =>
                      MemberModel.fromMap(member as Map<String, dynamic>),
                )
                .toList();
        lgr.w('got membersList: $members');
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

  FutureEither<List<MemberModel>> fetchMemberById(String id) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllMembers,
        queryParameters: {'id': id},
      );

      final token = await _secureStorage.read(key: 'token');

      final response = await _dioClient.get(
        uri.toString(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // final member = MemberModel.fromMap(response.data['data']);
        // return right(member);
         final List<dynamic> memberList = response.data['data'];
        final List<MemberModel> members =
            memberList
                .map(
                  (member) =>
                      MemberModel.fromMap(member as Map<String, dynamic>),
                )
                .toList();
        return right(members);

      } else {
        return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
      }
    } catch (err) {
      lgr.e('Error: $err');
      return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
    }
  }

  FutureEither<List<MemberModel>> fetchMemberByMobile(String mobile) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllMembers,
        queryParameters: {'phone_number': mobile},
      );

      final token = await _secureStorage.read(key: 'token');

      final response = await _dioClient.get(
        uri.toString(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> memberList = response.data['data'];
        final List<MemberModel> members =
            memberList
                .map(
                  (member) =>
                      MemberModel.fromMap(member as Map<String, dynamic>),
                )
                .toList();
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

  // Fetch members by name
  FutureEither<List<MemberModel>> fetchMembersByName(String name) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllMembers,
        queryParameters: {'name': name},
      );

      final token = await _secureStorage.read(key: 'token');
      final response = await _dioClient.get(
        uri.toString(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> memberList = response.data['data'];
        final List<MemberModel> members =
            memberList
                .map(
                  (member) =>
                      MemberModel.fromMap(member as Map<String, dynamic>),
                )
                .toList();
        return right(members);
      } else {
        return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
      }
    } catch (err) {
      lgr.e('Error: $err');
      return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
    }
  }

  // Fetch members by division
  FutureEither<List<MemberModel>> fetchMembersByDivision(
    String divisionId,
  ) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllMembers,
        queryParameters: {'division_id': divisionId},
      );

      final token = await _secureStorage.read(key: 'token');
      final response = await _dioClient.get(
        uri.toString(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> memberList = response.data['data'];
        final List<MemberModel> members =
            memberList
                .map(
                  (member) =>
                      MemberModel.fromMap(member as Map<String, dynamic>),
                )
                .toList();
        return right(members);
      } else {
        return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
      }
    } catch (err) {
      lgr.e('Error: $err');
      return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
    }
  }

  // Fetch members by both name and division
  FutureEither<List<MemberModel>> fetchMembersByNameAndDivision(
    String name,
    String divisionId,
  ) async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllMembers,
        queryParameters: {'name': name, 'division_id': divisionId},
      );

      final token = await _secureStorage.read(key: 'token');
      final response = await _dioClient.get(
        uri.toString(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> memberList = response.data['data'];
        final List<MemberModel> members =
            memberList
                .map(
                  (member) =>
                      MemberModel.fromMap(member as Map<String, dynamic>),
                )
                .toList();
        return right(members);
      } else {
        return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
      }
    } catch (err) {
      lgr.e('Error: $err');
      return left(Failure('সদস্যদের তথ্য আনতে গিয়ে একটি ত্রুটি ঘটেছে'));
    }
  }
}
