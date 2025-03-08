/* 

{
            "id": 5,
            "title": "উন্নয়ন, জনকল্যাণ ও সামার জন্য ১",
            "description": "আমরা প্রতিটি নাগরিকের কল্যাণ ও সমানাধিকারের জন্য কাজ করে যাচ্ছি, যাতে সবার জন্য একটি সমৃদ্ধ ও সুরক্ষিত ভবিষ্যৎ নিশ্চিত করা যায়।",
            "date": "2025-03-19 00:00:00",
            "image": "events/mZeMMs7t9vtjYMy7mBZXq9vRSi6dGF4zP0qSIDfc.jpg",
            "created_at": "2025-03-04T06:10:00.000000Z",
            "updated_at": "2025-03-04T06:10:00.000000Z",
            "division_id": "f47ea481-c504-4dc6-9bf5-350bbb200719",
            "district_id": "0bc234e0-3bf7-40bb-beb2-97de020d2468",
            "upazila_id": "c9f5cdb1-4589-4958-944a-6786de7a2468",
            "division_name": null,
            "district_name": null,
            "upazila_name": null,
            "address": "Dhamrai Govt. College"
        }

*/

class EventModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final String image;
  final String createdAt;
  final String updatedAt;
  final String divisionId;
  final String districtId;
  final String upazilaId;
  final String divisionName;
  final String districtName;
  final String upazilaName;
  final String address;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.divisionId,
    required this.districtId,
    required this.upazilaId,
    required this.divisionName,
    required this.districtName,
    required this.upazilaName,
    required this.address,
  });


  // fromJson

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      divisionId: json['division_id'],
      districtId: json['district_id'],
      upazilaId: json['upazila_id'],
      divisionName: json['division_name'],
      districtName: json['district_name'],
      upazilaName: json['upazila_name'],
      address: json['address'],
    );
  }

 
}
