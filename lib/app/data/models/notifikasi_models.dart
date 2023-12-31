class NotificationModel {
  String id;
  int notificationTypeId;
  bool isRead;
  String content;
  String userId;
  DateTime created;

  NotificationModel({
    required this.id,
    required this.notificationTypeId,
    required this.isRead,
    required this.content,
    required this.userId,
    required this.created,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      notificationTypeId: json['notificationTypeId'],
      isRead: json['isRead'],
      content: json['content'],
      userId: json['userId'],
      created: DateTime.parse(json['created']),
    );
  }
}
