import 'package:ease_studyante_app/src/teacher/pages/home/data/models/teacher_schedule_model.dart';

abstract class TeacherScheduleRepository {
  Future<TeacherScheduleModel> getTeacherSchedules({String? nextPage});
}
