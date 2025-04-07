class CourseModel {
  final int id;
  final String title;
  final int userId;
  final String description;
  final String courseImage;
  final String createdAt;
  final String updatedAt;
  final List<CourseFiles> courseFiles;

  CourseModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.description,
    required this.courseImage,
    required this.createdAt,
    required this.updatedAt,
    required this.courseFiles,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
      description: json['description'],
      courseImage: json['course_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      courseFiles: List<CourseFiles>.from(
        json['course_files'].map((data) => CourseFiles.fromJson(data)),
      ),
    );
  }
}

class CourseFiles {
  final int id;
  final int courseId;
  final String fileName;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  CourseFiles({
    required this.id,
    required this.courseId,
    required this.fileName,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseFiles.fromJson(Map<String, dynamic> json) {
    return CourseFiles(
      id: json['id'],
      courseId: json['course_id'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
