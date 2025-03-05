/*

নাম *
Type Here
জন্ম তারিখ *
mm/dd/yyyy
জাতীয় পরিচয়পত্র (NID) নম্বর
Type Here
ফোন নম্বর *
Type Here
ইমেইল *
Type Here
বিভাগ *
Select Division
জেলা *
Select District
উপজেলা
Select Upazila
পাসওয়ার্ড *
Enter Password
পাসওয়ার্ড নিশ্চিত করুন *

 */



 /*
 unsucessful registration response
 status code: 422
  {
    "success": false,
    "message": "Unprocessable Entity",
    "data": {
        "phone_number": [
            "এই নম্বর পূর্বে নিবন্ধিত হয়েছে।"
        ],
        "email": [
            "এই ইমেইল পূর্বে নিবন্ধিত হয়েছে।"
        ],
        "division_id": [
            "The selected division id is invalid."
        ],
        "district_id": [
            "The selected district id is invalid."
        ]
    }
}
  */

/* 

successful registration response           



*/
class RegisterInputModel {
  String name;
  String dob;
  String nid;
  String phone;
  String email;
  String division;
  String district;
  String upazila;
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
    required this.upazila,
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