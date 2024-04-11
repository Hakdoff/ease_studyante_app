import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';

abstract class TeacherAttendanceRepository {
  Future<List<StudentAttendanceModel>> getStudentAttendance({
    required String studentId,
    required String subjectId,
  });
}
