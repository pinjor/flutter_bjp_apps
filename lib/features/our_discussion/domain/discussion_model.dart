class DiscussionModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final int userId;
  final String createdAt;
  final String updatedAt;

  DiscussionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscussionModel.fromJson(Map<String, dynamic> json) {
    return DiscussionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
