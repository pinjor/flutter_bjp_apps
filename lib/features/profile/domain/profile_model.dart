// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/*



        "id": 34,
        "name": "Bjp",
        "email": "qepurysim@mailinator.com",
        "mobile": "01769769761",
        "email_verified_at": null,
        "mobile_verified_at": null,
        "created_at": "2025-03-10T09:59:27.000000Z",
        "updated_at": "2025-03-11T06:57:35.000000Z",
        "is_admin": 0,
        "member_registration_info": {
            "id": 33,
            "user_id": 34,
            "name": "Bjp",
            "birth_date": "1980-12-09T00:00:00.000000Z",
            "nid_number": "7697697691",
            "phone_number": "01769769761",
            "email": "qepurysim@mailinator.com",
            "created_at": "2025-03-10T09:59:27.000000Z",
            "updated_at": "2025-03-11T06:57:35.000000Z",
            "division_id": "8d02cf87-d0db-4112-b961-dcaceb68c084",
            "district_id": "933758b9-f830-4425-be3f-152cdb07d715",
            "upazila_id": "ade4bef6-0d38-4e6d-af31-65a23195e2af"
        },
        "roles": [
            {
                "id": 2,
                "name": "member",
                "guard_name": "web",
                "created_at": "2025-02-23T11:50:38.000000Z",
                "updated_at": "2025-02-23T11:50:38.000000Z",
                "pivot": {
                    "model_id": 34,
                    "role_id": 2,
                    "model_type": "App\\Models\\User"
                }
            }
        ]
    

 */

class ProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? emailVerifiedAt;
  final String? mobileVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? isAdmin;
  final MemberRegistrationInfo? memberRegistrationInfo;
  final List<Roles>? roles;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.memberRegistrationInfo,
    this.roles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'email_verified_at': emailVerifiedAt,
      'mobile_verified_at': mobileVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_admin': isAdmin,
      'member_registration_info': memberRegistrationInfo?.toMap(),
      'roles': roles?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      emailVerifiedAt:
          map['email_verified_at'] != null
              ? map['email_verified_at'] as String
              : null,
      mobileVerifiedAt:
          map['mobile_verified_at'] != null
              ? map['mobile_verified_at'] as String
              : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      isAdmin: map['is_admin'] != null ? map['is_admin'] as int : null,
      memberRegistrationInfo:
          map['member_registration_info'] != null
              ? MemberRegistrationInfo.fromMap(
                map['member_registration_info'] as Map<String, dynamic>,
              )
              : null,
      roles:
          map['roles'] != null
              ? List<Roles>.from(
                (map['roles'] as List).map<Roles?>(
                  (x) => Roles.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MemberRegistrationInfo {
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

  MemberRegistrationInfo({
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

  factory MemberRegistrationInfo.fromMap(Map<String, dynamic> map) {
    return MemberRegistrationInfo(
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

  factory MemberRegistrationInfo.fromJson(String source) =>
      MemberRegistrationInfo.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class Roles {
  final int? id;
  final String? name;
  final String? guardName;
  final String? createdAt;
  final String? updatedAt;
  final Pivot? pivot;

  Roles({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'guard_name': guardName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot?.toMap(),
    };
  }

  factory Roles.fromMap(Map<String, dynamic> map) {
    return Roles(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      guardName: map['guard_name'] != null ? map['guard_name'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      pivot:
          map['pivot'] != null
              ? Pivot.fromMap(map['pivot'] as Map<String, dynamic>)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Roles.fromJson(String source) =>
      Roles.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Pivot {
  final int? modelId;
  final int? roleId;
  final String? modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model_id': modelId,
      'role_id': roleId,
      'model_type': modelType,
    };
  }

  factory Pivot.fromMap(Map<String, dynamic> map) {
    return Pivot(
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      roleId: map['role_id'] != null ? map['role_id'] as int : null,
      modelType: map['model_type'] != null ? map['model_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pivot.fromJson(String source) =>
      Pivot.fromMap(json.decode(source) as Map<String, dynamic>);
}
