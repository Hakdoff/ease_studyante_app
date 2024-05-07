import 'dart:async';

import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat_session.dart';

abstract class ChatRepository {
  FutureOr<ChatModel> getChats({
    required String sessionId,
    String? next,
  });
  FutureOr<ChatSession> getChatSession(String roomName);
  FutureOr<ChatSession> createChatSession({
    required String roomName,
    required String personId,
    required String teacherId,
  });
}
