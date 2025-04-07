import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/media_repository.dart';

part 'media_controller.g.dart';

@riverpod
class MediaController extends _$MediaController {
  late final MediaRepository _mediaRepository;

  @override
  AsyncValue<dynamic> build() {
    _mediaRepository = ref.watch(mediaRepositoryProvider);

    return const AsyncValue.loading();
  }

  void fetchAllVideos() async {
    state = const AsyncValue.loading();

    final result = await _mediaRepository.fetchAllVideos();

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (videos) => state = AsyncValue.data(videos),
    );
  }

  void fetchAllPhotos() async {
    state = const AsyncValue.loading();

    final result = await _mediaRepository.fetchAllPhotos();

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (photos) => state = AsyncValue.data(photos),
    );
  }
}
