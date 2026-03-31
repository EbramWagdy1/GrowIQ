import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String type; // Critical, Environmental, Automation, AI, Informational
  final bool isRead;

  final String? deviceId;
  final String? deviceName;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.deviceId,
    this.deviceName,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? timestamp,
    String? type,
    bool? isRead,
    String? deviceId,
    String? deviceName,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'isRead': isRead,
      'deviceId': deviceId,
      'deviceName': deviceName,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      timestamp: json['timestamp'] is int 
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
          : DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
      type: json['type'] ?? 'Informational',
      deviceId: json['deviceId']?.toString(),
      deviceName: json['deviceName']?.toString(),
    );
  }

  @override
  List<Object?> get props => [id, title, body, timestamp, type, isRead, deviceId, deviceName];
}
