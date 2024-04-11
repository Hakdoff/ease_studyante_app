import 'dart:async';

import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/data/models/student_list_response_model.dart';

abstract class TeacherChatRepository {
  FutureOr<ChatModel> getChats({
    required String studentId,
    required String teacherId,
  });
  FutureOr<StudentListResponseModel> searchStudentChatList(
      {required String q, String? next});
}
