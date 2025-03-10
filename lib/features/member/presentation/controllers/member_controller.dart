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
  AsyncValue<List<MemberModel>> build(){
    _memberRepository = ref.watch(memberRepositoryProvider);
    return AsyncValue.data([]);
  }

  void fetchMembers(BuildContext context) async{
    state = AsyncValue.loading();
    lgr.i('fetching members');
    final result = await _memberRepository.fetchMembers();

    result.fold(
      (failure){
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (memberModels){
        state = AsyncValue.data(memberModels);
      },
    );
  }

  // New method to search members based on user inputs.
  void searchMembers(
    BuildContext context, {
    String? userId,
    String? mobile,
    String? name,
    String? division,
  }) async {
    state = AsyncValue.loading();

    // If user ID is provided, use fetchMemberById (assumed unique)
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
        (member) {
          state = AsyncValue.data(member);
        },
      );
      return;
    }

    // Else if mobile is provided, use fetchMemberByMobile (assumed unique)
    if (mobile != null && mobile.isNotEmpty) {
      final result = await _memberRepository.fetchMemberByMobile(mobile);
      result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
          showMessageToUser(context: context, message: failure.message);
        },
        (member) {
          state = AsyncValue.data(member);
        },
      );
      return;
    }

    // If both name and division are provided, use the combined search.
    if ((name != null && name.isNotEmpty) && (division != null && division.isNotEmpty)) {
      final result = await _memberRepository.fetchMembersByNameAndDivision(name, division);
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

    // Else if only name is provided.
    if (name != null && name.isNotEmpty) {
      final result = await _memberRepository.fetchMembersByName(name);
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

    // Else if only division is provided.
    if (division != null && division.isNotEmpty) {
      final result = await _memberRepository.fetchMembersByDivision(division);
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

    // If no search criteria provided, fetch all members.
    fetchMembers(context);
  }
}
