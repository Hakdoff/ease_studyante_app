import 'dart:convert';

import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String message;
  final String timeStamp;
  final String username;

  const Chat({
    required this.message,
    required this.timeStamp,
    required this.username,
  });

  Chat copyWith({
    String? message,
    String? timeStamp,
    String? username,
  }) {
    return Chat(
      message: message ?? this.message,
      timeStamp: timeStamp ?? this.timeStamp,
      username: username ?? this.username,
    );
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    final String username =
        map.containsKey('username') ? map["username"] : map['user']['username'];
    final String timestamp =
        map.containsKey('timestamp') ? map["timestamp"] : map['time_stamp'];

    return Chat(
      message: map['message'] ?? '',
      timeStamp: timestamp,
      username: username,
    );
  }

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() =>
      'Chat(message: $message, timeStamp: $timeStamp, username: $username)';

  @override
  List<Object> get props => [
        message,
        timeStamp,
        username,
      ];
}
