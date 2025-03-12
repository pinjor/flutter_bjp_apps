import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/announcement_repository.dart';
import '../../domain/announcement.dart';

part 'announcement_controller.g.dart';

@riverpod
class AnnouncementController extends _$AnnouncementController {
  late final AnnouncementRepository _announcementRepository;

  @override
  AsyncValue<List<Announcement>> build() {
    _announcementRepository = ref.watch(announcementRepositoryProvider);
    return AsyncValue.data([]);
  }

  void fetchAllAnnouncements(BuildContext context) async {
    state = AsyncValue.loading();
    lgr.i('fetching announcements');
    final result = await _announcementRepository.getAllAnnouncements();

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (announcements) {
        state = AsyncValue.data(announcements);
      },
    );
  }

  void fetchAnnouncementById(BuildContext context, String id) async {
    state = AsyncValue.loading();
    lgr.i('fetching announcement by id: $id');
    final result = await _announcementRepository.getAnnouncementById(id: id);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (announcement) {
        state = AsyncValue.data([announcement]);
      },
    );
  }

  void createAnnouncement(
    BuildContext context,
    String content,
    String divisionId,
  ) async {
    state = AsyncValue.loading();
    lgr.i('creating announcement');
    final result = await _announcementRepository.createAnnouncement(
      annoucement: content,
      divisionId: divisionId,
    );

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (_) {
        fetchAllAnnouncements(context);
        showMessageToUser(context: context, message: 'ঘোষণা সফলভাবে তৈরি হয়েছে');
      },
    );
  }

  void updateAnnouncement(
    BuildContext context,
    String id,
    String content,
    String divisionId,
  ) async {
    state = AsyncValue.loading();
    lgr.i('updating announcement');
    final result = await _announcementRepository.updateAnnouncement(
      id: id,
      announcement: content,
      divisionId: divisionId,
    );

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (_) {
        fetchAllAnnouncements(context);
      },
    );
  }

  void deleteAnnouncement(BuildContext context, String id) async {
    state = AsyncValue.loading();
    lgr.i('deleting announcement');
    final result = await _announcementRepository.deleteAnnouncement(id: id);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (_) {
        fetchAllAnnouncements(context);
      },
    );
  }
}
