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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'divisionId': divisionId,
      'districtId': districtId,
      'upazilaId': upazilaId,
      'divisionName': divisionName,
      'districtName': districtName,
      'upazilaName': upazilaName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      divisionId:
          map['divisionId'] != null ? map['divisionId'] as String : null,
      districtId:
          map['districtId'] != null ? map['districtId'] as String : null,
      upazilaId: map['upazilaId'] != null ? map['upazilaId'] as String : null,
      divisionName:
          map['divisionName'] != null ? map['divisionName'] as String : null,
      districtName:
          map['districtName'] != null ? map['districtName'] as String : null,
      upazilaName:
          map['upazilaName'] != null ? map['upazilaName'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source) as Map<String, dynamic>);
}
