import 'package:ease_studyante_app/src/teacher/pages/profile/domain/entities/teacher.dart';

abstract class TeacherProfileRepository {
  Future<Teacher> getTeacherProfile();
}
