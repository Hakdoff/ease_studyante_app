import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat.dart';

class ChatModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<Chat> chats;

  const ChatModel({
    this.nextPage,
    required this.totalCount,
    required this.chats,
  });

  ChatModel copyWith({
    String? nextPage,
    int? totalCount,
    List<Chat>? chats,
  }) {
    return ChatModel(
      nextPage: nextPage ?? this.nextPage,
      totalCount: totalCount ?? this.totalCount,
      chats: chats ?? this.chats,
    );
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      nextPage: map['next_page'],
      totalCount: map['count']?.toInt() ?? 0,
      chats: List<Chat>.from(map['results']?.map((x) => Chat.fromMap(x))),
    );
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  factory ChatModel.empty() => const ChatModel(totalCount: -1, chats: []);

  @override
  List<Object?> get props => [
        nextPage,
        totalCount,
        chats,
      ];
}
