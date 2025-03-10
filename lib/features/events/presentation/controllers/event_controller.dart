import 'package:bjp_app/features/events/domain/event_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/event_repository.dart';

part 'event_controller.g.dart';

@riverpod
class EventController extends _$EventController {
  late final EventRepository _eventRepository;

  @override
  AsyncValue<List<EventModel>> build() {
    _eventRepository = ref.watch(eventRepositoryProvider);
    // Initially, return an empty list.
    return AsyncValue.data([]);
  }

  void fetchEvents(BuildContext context) async {
    state = AsyncValue.loading();
    lgr.i('fetching events');
    final result = await _eventRepository.fetchEvents();

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        // You might want to show an error message to the user.
        // showMessageToUser(context: context, message: failure.message);
      },
      (eventModels) {
        state = AsyncValue.data(eventModels);
      },
    );
  }
}
