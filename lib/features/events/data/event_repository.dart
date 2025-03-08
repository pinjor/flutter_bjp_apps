import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/providers.dart';
import '../../../core/type_defs.dart';
import '../domain/event_model.dart';

part 'event_repository.g.dart';

@riverpod
EventRepository eventRepository(Ref ref) {
  return EventRepository(dioClient: ref.watch(dioProvider));
}

class EventRepository {
  final Dio _dioClient;

  EventRepository({required Dio dioClient}) : _dioClient = dioClient;

  FutureEither<List<EventModel>> fetchEvents() async {
    try {
      final uri = Uri(
        scheme: 'http',
        port: ApiConstants.port,
        host: ApiConstants.baseUrl,
        path: ApiConstants.getAllEvents,
      );
      final response = await _dioClient.get(uri.toString());

      if (response.statusCode == 200) {
        final eventModelList =
            (response.data as List)
                .map((el) => EventModel.fromJson(el))
                .toList();
        return right(eventModelList);
      } else {
        return left(Failure('ইভেন্ট গুলি পাওয়া যায়নি'));
      }
    } catch (err) {
      return left(Failure('ইভেন্ট গুলি পাওয়া যায়নি'));
    }
  }
}
