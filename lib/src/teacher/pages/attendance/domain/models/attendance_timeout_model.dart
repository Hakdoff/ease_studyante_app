import 'package:ease_studyante_app/src/teacher/pages/attendance/domain/models/attendance_student_timeout_item_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/domain/models/attendance_timeout_item_model.dart';

class AttendanceTimeOutModel {
  final AttendanceStudentTimeOutItemModel student;
  final AttendanceTimeoutItemModel attendance;

  AttendanceTimeOutModel({
    required this.attendance,
    required this.student,
  });

  factory AttendanceTimeOutModel.fromMap(Map<String, dynamic> map) {
    return AttendanceTimeOutModel(
      student: AttendanceStudentTimeOutItemModel.fromMap(
        map['student'] as Map<String, dynamic>,
      ),
      attendance: map['attendance'] == null
          ? AttendanceTimeoutItemModel.empty()
          : AttendanceTimeoutItemModel.fromMap(
              map['attendance'] as Map<String, dynamic>,
            ),
    );
  }

  factory AttendanceTimeOutModel.empty() {
    return AttendanceTimeOutModel(
      attendance: AttendanceTimeoutItemModel.empty(),
      student: AttendanceStudentTimeOutItemModel.empty(),
    );
  }
}
