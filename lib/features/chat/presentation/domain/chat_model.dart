import 'dart:convert';

class ChatModel {
  final int? id;
  final int? from_user_id;
  final int? receiver_user_id;
  final String? message;
  final int? messageId;
  final String? createdAt;
  final String? updatedAt;

  ChatModel({
    this.id,
    this.from_user_id,
    this.receiver_user_id,
    this.message,
    this.messageId,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from_user_id': from_user_id,
      'receiver_user_id': receiver_user_id,
      'message': message,
      'chat_id': messageId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as int : null,
      from_user_id: map['from_user_id'] != null ? map['from_user_id'] as int : null,
      receiver_user_id: map['receiver_user_id'] != null ? map['receiver_user_id'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      messageId: map['chat_id'] != null ? map['chat_id'] as int : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}