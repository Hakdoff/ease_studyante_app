import 'dart:async';

import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';

class TeacherChatRepositoryImpl extends TeacherChatRepository {
  @override
  FutureOr<ChatModel> getChats(
      {required String studentId, required String teacherId}) {
    // TODO: implement getChats
    throw UnimplementedError();
  }
}
