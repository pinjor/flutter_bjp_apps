class LoginResponseModel {
  bool? success;
  String? token;
  User? user;

  LoginResponseModel({this.success, this.token, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        success: json["success"],
        token: json["token"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? emailVerifiedAt;
  String? mobileVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? isAdmin;
  List<Role>? roles;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        // If the JSON values are null, these will be null as well.
        mobile: json["mobile"]?.toString(),
        emailVerifiedAt: json["email_verified_at"]?.toString(),
        mobileVerifiedAt: json["mobile_verified_at"]?.toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isAdmin: json["is_admin"],
        roles: json["roles"] != null
            ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "email_verified_at": emailVerifiedAt,
        "mobile_verified_at": mobileVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_admin": isAdmin,
        "roles": roles != null
            ? List<dynamic>.from(roles!.map((x) => x.toJson()))
            : null,
      };
}

class Role {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? modelId;
  int? roleId;
  String? modelType;

  Pivot({
    this.modelId,
    this.roleId,
    this.modelType,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
