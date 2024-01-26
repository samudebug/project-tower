class Message {
  String? id;
  String userId;
  String avatarUrl;
  String message;
  String attachment;
  DateTime createdAt;

  Message({this.id, required this.userId, required this.avatarUrl, required this.message, required this.attachment, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(id: json['id'], attachment: json['attachment'], avatarUrl: json['avatarUrl'], message: json['message'], userId: json['userId'], createdAt: json['createdAt'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'avatarUrl': avatarUrl,
      'message': message,
      'attachment': attachment,
      'createdAt': createdAt,
    };
  }
}