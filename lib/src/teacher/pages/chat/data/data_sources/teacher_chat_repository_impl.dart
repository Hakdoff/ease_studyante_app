import 'dart:async';

import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/user_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';

class TeacherChatRepositoryImpl extends TeacherChatRepository {
  @override
  FutureOr<ChatModel> getChats(
      {required String studentId, required String teacherId}) {
    // TODO: implement getChats
    throw UnimplementedError();
  }

  @override
  FutureOr<UserListResponseModel> searchUserChatList(
      {required String q, String? next}) async {
    final String url = '${AppConstant.apiUrl}/teacher/chat-list?q=$q';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      return UserListResponseModel.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
