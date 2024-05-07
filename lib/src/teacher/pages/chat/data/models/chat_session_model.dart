import 'dart:convert';

import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat_session.dart';
import 'package:equatable/equatable.dart';

class ChatSessionModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<ChatSession> chatSessions;

  const ChatSessionModel({
    this.nextPage,
    required this.totalCount,
    required this.chatSessions,
  });

  ChatSessionModel copyWith({
    String? nextPage,
    int? totalCount,
    List<ChatSession>? chatSessions,
  }) {
    return ChatSessionModel(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      chatSessions: chatSessions ?? this.chatSessions,
    );
  }

  factory ChatSessionModel.fromMap(Map<String, dynamic> map) {
    return ChatSessionModel(
      nextPage: map['next_page'],
      totalCount: map['count']?.toInt() ?? 0,
      chatSessions: List<ChatSession>.from(
          map['results']?.map((x) => ChatSession.fromMap(x))),
    );
  }

  factory ChatSessionModel.fromJson(String source) =>
      ChatSessionModel.fromMap(json.decode(source));

  factory ChatSessionModel.empty() =>
      const ChatSessionModel(totalCount: -1, chatSessions: []);

  @override
  List<Object?> get props => [
        nextPage,
        totalCount,
        chatSessions,
      ];
}
