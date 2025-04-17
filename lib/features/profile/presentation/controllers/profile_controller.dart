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

  void fetchUserProfile({required BuildContext context}) async {
    state = AsyncValue.loading();
    final result = await _profileRepository.fetchUserProfile();
    result.fold(
      (l) {
        lgr.e('Fetch profile failed: ${l.message}');
        state = AsyncValue.error(l.message, StackTrace.current);
        if (context.mounted) {
          showMessageToUser(context: context, message: l.message);
        }
      },
      (userProfile) {
        lgr.f(userProfile.toJson());
        lgr.i(
          'Profile fetched: name=${userProfile.name}, email=${userProfile.email}, mobile=${userProfile.mobile}, divisionId=${userProfile.memberRegistrationInfo?.divisionId}, districtId=${userProfile.memberRegistrationInfo?.districtId}, upazilaId=${userProfile.memberRegistrationInfo?.upazilaId}',
        );
        state = AsyncValue.data(userProfile);
      },
    );
  }

  void updateProfile({
    required String name,
    required String email,
    required String mobile,
    required String divisionId,
    required String districtId,
    required String upazilaId,
    required BuildContext context,
  }) async {
    state = AsyncValue.loading();
    final result = await _profileRepository.updateProfile(
      name: name,
      email: email,
      mobile: mobile,
      divisionId: divisionId,
      districtId: districtId,
      upazilaId: upazilaId,
    );
    // state = AsyncValue.data(null);
    // result.fold(
    //   (l) async => await showErrorDialog(context, errorMessage:l.message, title: l.title!),
    //   (r) => showMessageToUser(
    //     context: context,
    //     message: 'প্রোফাইল হালনাগাদ হয়েছে',
    //   ),
    // );
    result.fold(
      (l) async {
        state = AsyncValue.error(l, StackTrace.current);
        await showErrorDialog(
          context,
          errorMessage: l.message,
          title: l.title!,
        );
      },
      (r) {
        showMessageToUser(context: context, message: 'প্রোফাইল হালনাগাদ হয়েছে');
        // Re-fetch profile data after successful update
        fetchUserProfile(context: context);
      },
    );
  }
}
