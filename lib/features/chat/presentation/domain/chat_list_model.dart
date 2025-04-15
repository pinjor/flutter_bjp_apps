class ChatList {
  final int id;
  final User fromUser;
  final User receiverUser;
  final List<Message> messages;

  ChatList({
    required this.id,
    required this.fromUser,
    required this.receiverUser,
    required this.messages,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      id: json['id'],
      fromUser: User.fromJson(json['from_user']),
      receiverUser: User.fromJson(json['receiver_user']),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e))
          .toList(),
    );
  }

  Message? get lastMessage =>
      messages.isNotEmpty ? messages.last : null;
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Message {
  final int id;
  final int fromUserId;
  final int receiverUserId;
  final String message;
  final String createdAt;

  Message({
    required this.id,
    required this.fromUserId,
    required this.receiverUserId,
    required this.message,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      fromUserId: json['from_user_id'],
      receiverUserId: json['receiver_user_id'],
      message: json['message'],
      createdAt: json['created_at'],
    );
  }
}
