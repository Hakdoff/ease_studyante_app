import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';

abstract class AttendanceRepository {
  Future<List<StudentAttendanceModel>> getStudentAttendance({
    required String subjectId,
    required bool isParent,
    String? studentId,
  });
}
