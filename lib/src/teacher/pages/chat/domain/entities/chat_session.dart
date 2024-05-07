import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/user.dart';

class ChatSession extends Equatable {
  final String id;
  final String roomName;
  final User person;
  final User teacher;

  const ChatSession({
    required this.id,
    required this.roomName,
    required this.person,
    required this.teacher,
  });

  ChatSession copyWith({
    String? id,
    String? roomName,
    User? person,
    User? teacher,
  }) {
    return ChatSession(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      person: person ?? this.person,
      teacher: teacher ?? this.teacher,
    );
  }

  factory ChatSession.fromMap(Map<String, dynamic> map) {
    return ChatSession(
      id: map['id'] as String,
      roomName: map['room_name'] as String,
      person: User.fromMap(map['person'] as Map<String, dynamic>),
      teacher: User.fromMap(map['teacher'] as Map<String, dynamic>),
    );
  }

  factory ChatSession.fromJson(String source) =>
      ChatSession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        roomName,
        person,
        teacher,
        id,
      ];
}
