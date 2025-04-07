import 'package:bjp_app/core/constants/api_constants.dart';
import 'package:bjp_app/features/leadership_training/presentation/screens/course_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/course_model.dart';

class CourseCardWidget extends StatelessWidget {
  const CourseCardWidget({super.key, required this.course});
  final CourseModel course;

  void _viewCourseDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CourseDetailsScreen(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUri =
        Uri(
          scheme: 'http',
          host: ApiConstants.baseUrl,
          port: ApiConstants.port,
          path: 'storage/${course.courseImage}',
        ).toString();
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: imageUri,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                course.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // view button
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.centerRight,

              child: ElevatedButton(
                onPressed: () => _viewCourseDetails(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  maximumSize: Size(100, 40),
                ),
                child: Text('View'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
