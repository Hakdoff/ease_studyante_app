import 'dart:async';

import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_session_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/user_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat_session.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';

class TeacherChatRepositoryImpl extends TeacherChatRepository {
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
  FutureOr<UserListResponseModel> searchUserChatList(
      {required String q, String? next}) async {
    final String url = '${AppConstant.apiUrl}/chat-sessions/search?q=$q';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      return UserListResponseModel.fromMap(value.data);
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

  @override
  FutureOr<ChatSessionModel> getChatList({String? next}) async {
    String url = '${AppConstant.apiUrl}/chat-sessions';

    if (next != null) {
      url = next;
    }

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;

      final schedules = results.map((e) => ChatSession.fromMap(e)).toList();
      return ChatSessionModel(
          chatSessions: schedules,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
