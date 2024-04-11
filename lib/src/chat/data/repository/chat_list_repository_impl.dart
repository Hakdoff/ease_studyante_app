import 'dart:async';

import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/chat/data/models/chat_list_model.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_list_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/domain/entities/teacher.dart';

class ChatListRepositoryImpl extends ChatListRepository {
  @override
  FutureOr<ChatListModel> getChatList({String? nextPage}) async {
    String url = nextPage ?? '${AppConstant.apiUrl}/student/chat-list';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final teachers =
          results.map((e) => Teacher.chatFromMap(e['teacher'])).toList();

      return ChatListModel(
          teachers: teachers,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
