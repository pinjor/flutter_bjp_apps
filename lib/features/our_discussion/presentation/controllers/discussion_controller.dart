import 'package:bjp_app/features/our_discussion/data/discussion_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/discussion_model.dart';

part 'discussion_controller.g.dart';

@riverpod
class DiscussionController extends _$DiscussionController {
  late final DiscussionRepository _discussionRepository;

  @override
  AsyncValue<List<DiscussionModel>> build() {
    _discussionRepository = ref.watch(discussionRepositoryProvider);
    return AsyncValue.data([]);
  }

  /// Fetches all discussions for initial load
  void fetchAllDiscussions(BuildContext context) async {
    state = AsyncValue.loading();
    lgr.i('Fetching all discussions');
    final result = await _discussionRepository.fetchAllDiscussions();
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (discussions) {
        state = AsyncValue.data(discussions);
      },
    );
  }
}
