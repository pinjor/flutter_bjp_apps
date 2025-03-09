import 'dart:convert';

class EventModel {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final String? divisionId;
  final String? districtId;
  final String? upazilaId;
  final String? divisionName;
  final String? districtName;
  final String? upazilaName;
  final String? address;

  EventModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.divisionId,
    this.districtId,
    this.upazilaId,
    this.divisionName,
    this.districtName,
    this.upazilaName,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'division_id': divisionId,
      'district_id': districtId,
      'upazila_id': upazilaId,
      'division_name': divisionName,
      'district_name': districtName,
      'upazila_name': upazilaName,
      'address': address,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      divisionId: map['division_id'] != null ? map['division_id'] as String : null,
      districtId: map['district_id'] != null ? map['district_id'] as String : null,
      upazilaId: map['upazila_id'] != null ? map['upazila_id'] as String : null,
      divisionName: map['division_name'] != null ? map['division_name'] as String : null,
      districtName: map['district_name'] != null ? map['district_name'] as String : null,
      upazilaName: map['upazila_name'] != null ? map['upazila_name'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}