import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/event_repository.dart';

part 'event_controller.g.dart';

@riverpod
class EventController extends _$EventController {
  late final EventRepository _eventRepository;

  @override
  AsyncValue<dynamic> build() {
    _eventRepository = ref.watch(eventRepositoryProvider);
    return AsyncValue.data([]);
  }

  void fetchEvents(BuildContext context) async {
    state = AsyncValue.loading();
    final result = await _eventRepository.fetchEvents();

    result.fold((failure) {
      state = AsyncValue.data(null);

      showMessageToUser(context: context, message: failure.message);
    }, (eventModel) => state = AsyncValue.data(eventModel));
  }
}
