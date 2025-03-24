import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../data/courses_repository.dart';
import '../../domain/course_model.dart';

part 'courses_controller.g.dart';

@riverpod
class CoursesController extends _$CoursesController{
  late final CoursesRepository _coursesRepository;


  @override
  AsyncValue<List<CourseModel>> build() {
    _coursesRepository = ref.watch(coursesRepositoryProvider);
    return AsyncValue.data([]);
  }


  /// Fetches all courses for initial load
  void fetchAllCourses(BuildContext context) async {
    state = AsyncValue.loading();
    lgr.i('Fetching all courses');
    final result = await _coursesRepository.fetchAllCourses();
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        showMessageToUser(context: context, message: failure.message);
      },
      (courses) {
        state = AsyncValue.data(courses);
      },
    );
  }
}