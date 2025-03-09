import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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


}