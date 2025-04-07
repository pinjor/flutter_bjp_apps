import 'package:intl/intl.dart';

class RecentAnnouncement {
  int? id;
  String? title;
  String? content;
  String? createdAt;

  RecentAnnouncement({this.id, this.title, this.content, this.createdAt});

  factory RecentAnnouncement.fromJson(Map<String, dynamic> json) {
    return RecentAnnouncement(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.parse(json['created_at'])),
    );
  }
}
