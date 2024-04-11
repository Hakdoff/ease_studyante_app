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
    return Chat(
      message: map['message'] ?? '',
      timeStamp: map['time_stamp'] ?? '',
      username: map['username'] ?? '',
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
