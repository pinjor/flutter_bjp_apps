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

2: 

{"success":true,"message":"Registration successful!","user":{"name":"Sanjida","email":"sanjida.islam2@egeneration.com","mobile":"01637541562","updated_at":"2025-03-06T03:32:24.000000Z","created_at":"2025-03-06T03:32:24.000000Z","id":9,"is_admin":0,"roles":[{"id":2,"name":"member","guard_name":"web","created_at":"2025-02-23T11:50:38.000000Z","updated_at":"2025-02-23T11:50:38.000000Z","pivot":{"model_id":9,"role_id":2,"model_type":"App\\Models\\User"}}]},"registration_info":{"user_id":9,"name":"Sanjida","email":"sanjida.islam2@egeneration.com","phone_number":"01637541562","birth_date":"2001-10-10T00:00:00.000000Z","nid_number":"1234567890","division_id":"f47ea481-c504-4dc6-9bf5-350bbb200719","district_id":"0bc234e0-3bf7-40bb-beb2-97de020d2468","upazila_id":null,"updated_at":"2025-03-06T03:32:24.000000Z","created_at":"2025-03-06T03:32:24.000000Z","id":8},"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYmE0ZmY1ZjlmOGMzM2I5OWQ3MWNhZWMyOTNhYzMzYmJiMDU2ZTEzNDRlYzg5ZDllN2VlNmVjOGYwN2EyZjkwMTZmYzUzZWU4NDllN2JlMTkiLCJpYXQiOjE3NDEyMzE5NDQuODExMDI2LCJuYmYiOjE3NDEyMzE5NDQuODExMDI3LCJleHAiOjE3NzI3Njc5NDQuODA4Mjk2LCJzdWIiOiI5Iiwic2NvcGVzIjpbXX0.OIZJ8kTvCN_2KaMulfwVBDgBxk0wUbMBpNYK-_jyibwtzuglhBCrR8yXJxsdwWd68meCe-6mzB_ZJJ7ZKhKR9vjDKn42DvWLJrVU7CHh-e2Vo1J7-cPk8JKNX78meDPei1bEkFdSygRgdfz4ek39BmfpkJ9agZTSC44wYYKvsmd8qAm44kGdx6OBdG369YfCZtrDz6U6trR3jF3rjTTxvjVAaImRi3ws_bF8Yin5eGUwPS1Zgp__DVXMk8olk3bDZABBWpkTZ1xAMjN_NeuZiI3TLCoFkIayri8AzLDHeX9POvjg3vqIhtP0P4Q1OlsL7WOLq2hzEdm1JQnjuvBmdJt7KcFIFZg3eHeiuTXDitqygUMzM0dlo-ik5X6KYX0phVQoldoWPtEQ-_z4S56riReIBC0C-dSd4ggGMLCyJEDvqUP5qkkl0VpqM3Lx3BEXv5ECHoNgXbl23Qq00SEl_QLEtGtiIXiDytdmtzMZ6HXXqVnwDrwaxastMcxoZPsgVZCfLfWIGICkvENmpuTiVTrh30QMLBn2qw5wathwMhUjWX9u6-8gTCMVeYf7R7eAhL_KZoBtgi5KfcBH2Vj4FYrI7eCkaK_VTBbZZw3YmvOxVI3Ga5lrlo5b2cPSP-Lqu7ardZTAh9L39CJ3n3syuX0nDcU756C6htrtlmH3R3k"}


3:

{
    "success": true,
    "message": "Registration successful!",
    "user": {
        "name": "Sanjida",
        "email": "sanjida.islam2@egeneration.comm",
        "mobile": "01637541563",
        "updated_at": "2025-03-06T03:34:02.000000Z",
        "created_at": "2025-03-06T03:34:02.000000Z",
        "id": 10,
        "is_admin": 0,
        "roles": [
            {
                "id": 2,
                "name": "member",
                "guard_name": "web",
                "created_at": "2025-02-23T11:50:38.000000Z",
                "updated_at": "2025-02-23T11:50:38.000000Z",
                "pivot": {
                    "model_id": 10,
                    "role_id": 2,
                    "model_type": "App\\Models\\User"
                }
            }
        ]
    },
    "registration_info": {
        "user_id": 10,
        "name": "Sanjida",
        "email": "sanjida.islam2@egeneration.comm",
        "phone_number": "01637541563",
        "birth_date": "2001-10-10T00:00:00.000000Z",
        "nid_number": "1234567890",
        "division_id": "f47ea481-c504-4dc6-9bf5-350bbb200719",
        "district_id": "0bc234e0-3bf7-40bb-beb2-97de020d2468",
        "upazila_id": null,
        "updated_at": "2025-03-06T03:34:02.000000Z",
        "created_at": "2025-03-06T03:34:02.000000Z",
        "id": 9
    },
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTMzOTdhNDYyMDAxMmM5MjNkNWE1M2E3NTA5NjJiMDlmMDEyNWI1MTc2NWFiN2IzNzZkYmUwM2Y5MTZiMjFjM2JjODkwYmY5NDhkOTE2NDgiLCJpYXQiOjE3NDEyMzIwNDIuODY5MjMsIm5iZiI6MTc0MTIzMjA0Mi44NjkyMzIsImV4cCI6MTc3Mjc2ODA0Mi44NjY3NDIsInN1YiI6IjEwIiwic2NvcGVzIjpbXX0.ftjToavu2ykjj4_2AIjZHmm-8kyetqlyMoM6oZt3g_MN8VZnkaYbtaLC5MQlDFS8ZffNgYlVFewL2ypiaQMHI_yg0uZxSSMYi0F59FEZIhDaOCFVxul_YY8mXwYHqvgL1ZmCai6dTaOSvqTS_MOQBLH3tSdvdi18W6xYb_2JeiN1dxaeAeZdyaNGyO-eRdGG7IMvc9fQ7Fku6phakI3V29ceoW831adS-iUQFK8X4odYOkpm8SPToRqVtl5y_UlgSYeMAZRC0nzSCdgfggxGCT36c2C3bCjwg17Avo_qI3cUiivo03WuLyJm364n-ThnAZutRPRWeJPMSE8adkVlNnx54axfTytgbRgVV-LxPnQBN-W0VAV4BrgXkowuPqKrWXVjRusIqOtPzugOptHbg5RQsUaAQFeI-5IchXwrQdTzmtpTE_e6Z8aTk-wsYal43KeBDA8-hsr5AfZDiSUL5QV8-YwFqCPtpOsQpzEW0LHwzQrVRWC7sSPOXgK83hgreNWVs2mXS7l7BqLbWUSZYdP_8TvShqWkFeCsXtzMWF5kjmOCz73ZAmstJ_hehrwWLc_SGHOPAe9pqhhyh3rWQKQ-JiBoQx-A_IVziBJ-RQkhW89pFld97J8o1zWR5bxOi8B4reU9IriSmpxlTUfI9ktc6e6Q0dWq_-bc-NAy9Dc"
}


*/
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
