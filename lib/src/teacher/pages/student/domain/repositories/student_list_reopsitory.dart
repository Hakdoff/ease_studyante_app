import 'package:ease_studyante_app/src/teacher/pages/student/data/models/student_list_response_model.dart';

abstract class StudentListRepository {
  Future<StudentListResponseModel> getStudentList(
      {required String section, String? next});
}
