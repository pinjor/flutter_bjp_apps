import 'package:bjp_app/features/leadership_training/presentation/widgets/course_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/courses_controller.dart';

class LeadershipTrainingScreen extends ConsumerStatefulWidget {
  const LeadershipTrainingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeadershipTrainingScreenState();
}

class _LeadershipTrainingScreenState
    extends ConsumerState<LeadershipTrainingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coursesControllerProvider.notifier).fetchAllCourses(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final coursesList = ref.watch(coursesControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('লিডারশিপ ট্রেনিং'), centerTitle: true),

      body: SafeArea(
        child: coursesList.when(
          data: (courses) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (_, i) {
                  final course = courses[i];

                  return CourseCardWidget(
                    course: course,
                  );
                },
              ),
            );
          },
          error: (err, st) {
            return Center(child: Text(err.toString()));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
