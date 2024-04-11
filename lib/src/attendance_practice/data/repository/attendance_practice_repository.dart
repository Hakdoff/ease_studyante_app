import 'package:ease_studyante_app/src/attendance_practice/domain/models/student_attendance_practice_model.dart';

abstract class AttendancePracticeRepository {
  Future<List<StudentAttendancePraticeModel>> getStudentAttendancePracticeModel(
      String subjectId);
}
