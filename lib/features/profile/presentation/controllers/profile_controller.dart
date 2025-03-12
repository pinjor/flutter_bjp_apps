import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/profile_repository.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  late final ProfileRepository _profileRepository;
  @override
  AsyncValue<dynamic> build() {
    _profileRepository = ref.watch(profileRepositoryProvider);
          
    return AsyncValue.data(null);
  }

  void updateProfile({
    required String userName,
    required BuildContext context,
  }) async {
    state = AsyncValue.loading();

    final result = await _profileRepository.updateProfile(userName: userName);

    state = AsyncValue.data(null);

    result.fold(
      (l) {
        // state = AsyncValue.error();
        showMessageToUser(context: context, message: l.message);
      },
      (r) {

        showMessageToUser(context: context, message: 'প্রোফাইল হালনাগাদ হয়েছে');
      },
    );
  }
}
