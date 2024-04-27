import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/domain/models/attendance_timeout_model.dart';

abstract class TeacherAttendanceRepository {
  Future<List<StudentAttendanceModel>> getStudentAttendance({
    required String studentId,
    required String subjectId,
  });

  Future<List<AttendanceTimeOutModel>> getStudentTimeoutList({
    required String scheduleId,
  });

  Future<List<AttendanceTimeOutModel>> postStudentTimeoutList({
    required String scheduleId,
    required List<String> studentIds,
  });
}
