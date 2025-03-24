import 'package:bjp_app/config/app_colors.dart';
import 'package:bjp_app/features/leadership_training/domain/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/file_card.dart';

class CourseDetailsScreen extends ConsumerStatefulWidget {
  const CourseDetailsScreen({super.key, required this.course});
  final CourseModel course;

  @override
  ConsumerState<CourseDetailsScreen> createState() =>
      _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends ConsumerState<CourseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Title
              Stack(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(color: AppColors.themeColor),
                    child: Center(
                      child: Text(
                        widget.course.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Course Details Header
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Course Details:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              // Course Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Html(data: widget.course.description),
              ),

              // Course Files Header
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  'Download Course Files:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Course Files in Horizontal Row
              SizedBox(
                height: 120, // Adjust height based on your card size
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Horizontal scrolling
                    shrinkWrap: true,
                    itemCount: widget.course.courseFiles.length,
                    itemBuilder: (_, i) {
                      final file = widget.course.courseFiles[i];
                      return SizedBox(
                        width: 150, // Fixed width for each card
                        child: FileCard(file: file),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
