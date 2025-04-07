class VideoModel {
  final int? id;
  final String? title;
  final String? type;
  final int? userId;
  final String? description;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final List<VideoGalleryModel>? galleries;

  VideoModel({
    this.id,
    this.title,
    this.type,
    this.userId,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      galleries: List<VideoGalleryModel>.from(
        (map['galleries']).map<VideoGalleryModel>(
          (x) => VideoGalleryModel.fromMap(x),
        ),
      ),
    );
  }
}

class VideoGalleryModel {
  final int? id;
  final int? albumId;
  final String? type;
  final String? comment;
  final String? path;
  final String? previewImage;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;

  VideoGalleryModel({
    this.id,
    this.albumId,
    this.type,
    this.comment,
    this.path,
    this.previewImage,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory VideoGalleryModel.fromMap(Map<String, dynamic> map) {
    return VideoGalleryModel(
      id: map['id'] != null ? map['id'] as int : null,
      albumId: map['album_id'] != null ? map['album_id'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      previewImage:
          map['preview_image'] != null ? map['preview_image'] as String : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }
}
