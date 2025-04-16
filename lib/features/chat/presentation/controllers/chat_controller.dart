import 'package:bjp_app/features/chat/data/chat_repository.dart';
import 'package:bjp_app/features/chat/presentation/domain/chat_model.dart';
import 'package:bjp_app/features/events/domain/event_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/chat_repository.dart';


part 'chat_controller.g.dart';
@riverpod
class ChatController extends _$ChatController {
  late final ChatRepository _chatRepository;

  @override
  AsyncValue<List<ChatModel>> build() {
    _chatRepository = ref.watch(chatRepositoryProvider);
    // Initially, return an empty list.
    return AsyncValue.data([]);
  }

  void fetchChatMessages(String partnerId) async {
    state = AsyncValue.loading();
    lgr.i('fetching chats');
    final result = await _chatRepository.fetchChatMessages(partnerId);

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

  void sendMessage(BuildContext context, String receiverId, String text)  async {

    final result = await _chatRepository.sendMessage(receiverId,text);

    // state = AsyncValue.data([]);

    result.fold(
          (l) {
        // state = AsyncValue.error();
        showMessageToUser(context: context, message: l.message);
      },
          (r) {

        // showMessageToUser(context: context, message: 'চ্যাট পাঠানো হয়েছে');
      },
    );
  }
}
