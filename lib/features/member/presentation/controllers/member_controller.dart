import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/failure.dart';
import '../../../../core/utils/utils.dart';
import '../../data/member_repository.dart';
import '../../domain/member_model.dart';

part 'member_controller.g.dart';

@riverpod
class MemberController extends _$MemberController {
  late final MemberRepository _memberRepository;

  @override
  AsyncValue<List<MemberModel>> build() {
    _memberRepository = ref.watch(memberRepositoryProvider);
    return AsyncValue.data([]);
  }

  /// Fetches all members for initial load
  void fetchMembers(BuildContext context) async {
    state = AsyncValue.loading();
    lgr.i('Fetching members');
    final result = await _memberRepository.searchMembers();
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (members) {
        state = AsyncValue.data(members);
      },
    );
  }

  /// Searches members based on user inputs
  void searchMembers(
    BuildContext context, {
    String? userId,
    String? mobile,
    String? name,
    String? divisionId,
    String? districtId,
    String? subdistrictId,
  }) async {
    state = AsyncValue.loading();

    // Handle search by unique user ID
    if (userId != null && userId.isNotEmpty) {
      final int? id = int.tryParse(userId);
      if (id == null) {
        state = AsyncValue.error(Failure('Invalid User Id'), StackTrace.current);
        showMessageToUser(context: context, message: 'Invalid User Id');
        return;
      }
      final result = await _memberRepository.fetchMemberById(id.toString());
      result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
          showMessageToUser(context: context, message: failure.message);
        },
        (members) {
          state = AsyncValue.data(members);
        },
      );
      return;
    }

    // Handle search by unique mobile number
    if (mobile != null && mobile.isNotEmpty) {
      final result = await _memberRepository.fetchMemberByMobile(mobile);
      result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
          showMessageToUser(context: context, message: failure.message);
        },
        (members) {
          state = AsyncValue.data(members);
        },
      );
      return;
    }

    // Handle all other combinations using searchMembers
    final result = await _memberRepository.searchMembers(
      name: name,
      divisionId: divisionId,
      districtId: districtId,
      subdistrictId: subdistrictId,
    );
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (members) {
        state = AsyncValue.data(members);
      },
    );
  }
}