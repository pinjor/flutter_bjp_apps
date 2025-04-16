// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/* 
 {
            "id": 4,
            "title": null,
            "content": null,
            "user_id": 1,
            "division_id": "f47ea481-c504-4dc6-9bf5-350bbb200719",
            "district_id": null,
            "upazila_id": null,
            "division_name": "Dhaka",
            "district_name": null,
            "upazila_name": null,
            "created_at": "2025-03-04T06:35:07.000000Z",
            "updated_at": "2025-03-10T08:40:11.000000Z"
        }

*/

class Announcement {
  final int? id;
  final String? title;
  final String? content;
  final int? userId;
  final String? divisionId;
  final String? districtId;
  final String? upazilaId;
  final String? divisionName;
  final String? districtName;
  final String? upazilaName;
  final String? createdAt;
  final String? updatedAt;

  final bool? is_for_all_division;

  Announcement({
    this.id,
    this.title,
    this.content,
    this.userId,
    this.divisionId,
    this.districtId,
    this.upazilaId,
    this.divisionName,
    this.districtName,
    this.upazilaName,
    this.createdAt,
    this.updatedAt,
    this.is_for_all_division,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'user_id': userId,
      'division_id': divisionId,
      'district_id': districtId,
      'upazila_id': upazilaId,
      'division_name': divisionName,
      'district_name': districtName,
      'upazila_name': upazilaName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_for_all_division': is_for_all_division,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      divisionId:
          map['division_id'] != null ? map['division_id'] as String : null,
      districtId:
          map['district_id'] != null ? map['district_id'] as String : null,
      upazilaId: map['upazila_id'] != null ? map['upazila_id'] as String : null,
      divisionName:
          map['division_name'] != null ? map['division_name'] as String : null,
      districtName:
          map['district_name'] != null ? map['district_name'] as String : null,
      upazilaName:
          map['upazila_name'] != null ? map['upazila_name'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      is_for_all_division:
          map['is_for_all_division'] != null
              ? map['is_for_all_division'] as bool
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source) as Map<String, dynamic>);
}
