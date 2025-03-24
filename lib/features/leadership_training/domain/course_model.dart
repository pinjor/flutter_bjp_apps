/*

please make me a dart data model class for this json(for the data part only)

{
    "success": true,
    "message": "OK",
    "data": [
        {
            "id": 3,
            "title": "Abc",
            "user_id": 1,
            "description": "<p><span style=\"color: var(--tw-prose-bold);\">The leadership Certificate awarded by Istanbul Business Institute (IIENSTITU)</span>&nbsp;is globally recognized and companies like Google, Deloitte, Bank of America prefer to hire people with Leadership Certificates. If you are looking for professional development that attracts high salaries, Leadership Course offered by IIENSTITU will be your first choice!</p><p><span style=\"color: var(--tw-prose-bold);\">The Leadership Certificate awarded by Institute comes with the following benefits:</span></p><ul><li>Ability to share on LinkedIn profile.</li><li>Opportunity to become Certified Leader, thus opening the door for senior roles in business communities</li><li>The leadership certificate issued by Institute is globally recognized and can be shared on any social media.</li></ul><p>If you are looking for Leadership courses that offer a Leadership certificate that will open the door to more professional opportunities and help you earn more, the IIENSTITU Leadership course is your best option!</p><p><br></p>",
            "course_image": "course_images/cM9DXc84Fi3kR8vh7iHp0slOOA9vGDGSHaRMEFUT.jpg",
            "created_at": "2025-03-03T09:41:46.000000Z",
            "updated_at": "2025-03-04T06:13:08.000000Z",
            "course_files": [
                {
                    "id": 3,
                    "course_id": 3,
                    "file_name": "demo_course.pdf",
                    "file_path": "course_files/gI6FASwg1eovi7r2auGMDFTLAF1ftIUmVideqv48.pdf",
                    "created_at": "2025-03-03T09:42:01.000000Z",
                    "updated_at": "2025-03-03T09:42:01.000000Z"
                },
                {
                    "id": 4,
                    "course_id": 3,
                    "file_name": "demo_course.docx",
                    "file_path": "course_files/h2tycK9oxuRkz6gaqgV81SOUoQg7Dn05ENK6eow2.docx",
                    "created_at": "2025-03-03T09:42:01.000000Z",
                    "updated_at": "2025-03-03T09:42:01.000000Z"
                }
            ]
        },
        {
            "id": 5,
            "title": "People-analytics",
            "user_id": 1,
            "description": "<p>This course is part of the&nbsp;<a href=\"https://www.coursera.org/specializations/business-analytics\" target=\"_blank\" style=\"color: var(--cds-color-interactive-primary); background-color: transparent;\">Business Analytics Specialization</a></p><p>When you enroll in this course, you'll also be enrolled in this Specialization.</p><ul><li>Learn new concepts from industry experts</li><li>Gain a foundational understanding of a subject or tool</li><li>Develop job-relevant skills with hands-on projects</li><li>Earn a shareable career certificate</li></ul><p><br></p>",
            "course_image": "course_images/IU3RavJc2b4himvrY6CGXXHWMhH5QknJclST0zbM.jpg",
            "created_at": "2025-03-04T06:02:26.000000Z",
            "updated_at": "2025-03-04T06:06:33.000000Z",
            "course_files": [
                {
                    "id": 5,
                    "course_id": 5,
                    "file_name": "demo_course.pdf",
                    "file_path": "course_files/g5cyg9ZpbddsImbuIBnT2H6XjETtTtKcsb5WY4sv.pdf",
                    "created_at": "2025-03-04T06:05:11.000000Z",
                    "updated_at": "2025-03-04T06:05:11.000000Z"
                },
                {
                    "id": 6,
                    "course_id": 5,
                    "file_name": "demo_course.docx",
                    "file_path": "course_files/lvOeTawgiwlVYNbpku0acgdwos8EdNtclW2xK6V5.docx",
                    "created_at": "2025-03-04T06:05:11.000000Z",
                    "updated_at": "2025-03-04T06:05:11.000000Z"
                }
            ]
        }
    ]
}

 */

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
