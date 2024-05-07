import 'dart:async';

import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat_session.dart';

class ChatRepositoryImpl extends ChatRepository {
  @override
  FutureOr<ChatModel> getChats({
    required String sessionId,
    String? next,
  }) async {
    String url = '${AppConstant.apiUrl}/chat-messages?session_id=$sessionId';

    if (next != null) {
      url = next;
    }

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      return ChatModel.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  FutureOr<ChatSession> createChatSession(
      {required String roomName,
      required String personId,
      required String teacherId}) async {
    const String url = '${AppConstant.apiUrl}/chat-sessions';

    final data = {
      "person_id": personId,
      "teacher_id": teacherId,
      "room_name": roomName
    };

    return await ApiInterceptor.apiInstance()
        .post(
      url,
      data: data,
    )
        .then((value) {
      return ChatSession.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  FutureOr<ChatSession> getChatSession(String roomName) async {
    final String url =
        '${AppConstant.apiUrl}/chat-session/retrieve?room_name=$roomName';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      return ChatSession.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
