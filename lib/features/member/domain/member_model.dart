/* 
  This class is used to represent the member model in the domain layer.
  It is used to pass data between the domain and data layers.

   {
            "id": 1,
            "user_id": 2,
            "name": "Sanjida Islam",
            "birth_date": "1996-10-14T00:00:00.000000Z",
            "nid_number": "8765434567",
            "phone_number": "01637641560",
            "email": "gsdgdf@gmail.com",
            "created_at": "2025-02-23T11:58:46.000000Z",
            "updated_at": "2025-02-23T11:58:46.000000Z",
            "division_id": "f47ea481-c504-4dc6-9bf5-350bbb200719",
            "district_id": "0bc234e0-3bf7-40bb-beb2-97de020d2468",
            "upazila_id": "7b948ada-e2a7-4a68-9633-e23f337204e3"
        },



*/

import 'dart:convert';

class MemberModel {
  final int? id;
  final int? userId;
  final String? name;
  final String? birthDate;
  final String? nidNumber;
  final String? phoneNumber;
  final String? email;
  final String? createdAt;
  final String? updatedAt;
  final String? divisionId;
  final String? districtId;
  final String? upazilaId;

  MemberModel({
    this.id,
    this.userId,
    this.name,
    this.birthDate,
    this.nidNumber,
    this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.divisionId,
    this.districtId,
    this.upazilaId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'birth_date': birthDate,
      'nid_number': nidNumber,
      'phone_number': phoneNumber,
      'email': email,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'division_id': divisionId,
      'district_id': districtId,
      'upazila_id': upazilaId,
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      birthDate: map['birth_date'] != null ? map['birth_date'] as String : null,
      nidNumber: map['nid_number'] != null ? map['nid_number'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      divisionId:
          map['division_id'] != null ? map['division_id'] as String : null,
      districtId:
          map['district_id'] != null ? map['district_id'] as String : null,
      upazilaId: map['upazila_id'] != null ? map['upazila_id'] as String : null,
    );
  }


  String toJson() => json.encode(toMap());

  factory MemberModel.fromJson(String source) =>
      MemberModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
