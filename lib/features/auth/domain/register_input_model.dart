class RegisterInputModel {
  String name;
  String dob;
  String nid;
  String phone;
  String email;
  String division;
  String district;
  String? upazila;
  String password;
  String confirmPassword;

  RegisterInputModel({
    required this.name,
    required this.dob,
    required this.nid,
    required this.phone,
    required this.email,
    required this.division,
    required this.district,
    this.upazila,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birth_date': dob,
      'nid_number': nid,
      'phone_number': phone,
      'email': email,
      'division_id': division,
      'district_id': district,
      'upazila_id': upazila,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }
}
