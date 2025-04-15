import 'package:bjp_app/features/chat/data/chat_repository.dart';
import 'package:bjp_app/features/chat/presentation/domain/chat_list_model.dart';
import 'package:bjp_app/features/chat/presentation/domain/chat_model.dart';
import 'package:bjp_app/features/events/domain/event_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/chat_repository.dart';


part 'chat_list_controller.g.dart';
@riverpod
class ChatController extends _$ChatController {
  late final ChatRepository _chatRepository;


  @override
  AsyncValue<List<ChatList>> build() {
    _chatRepository = ref.watch(chatRepositoryProvider);
    // Initially, return an empty list.
    return AsyncValue.data([]);
  }
  void fetchChatList() async {
    state = AsyncValue.loading();
    lgr.i('fetching chat list');
    final result = await _chatRepository.fetchChatList();

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        // You might want to show an error message to the user.
        // showMessageToUser(context: context, message: failure.message);
      },
      (chatModels) {
        state = AsyncValue.data(chatModels);
      },
    );
  }
}
