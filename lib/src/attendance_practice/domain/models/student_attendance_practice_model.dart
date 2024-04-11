import 'dart:convert';

import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';

class StudentAttendancePraticeModel {
  final String id;
  final String timeIn;
  final String? timeOut;
  final bool isPresent;
  final String attendanceDate;
  final ScheduleModel schedule;
  final Student student;

  StudentAttendancePraticeModel({
    required this.id,
    required this.timeIn,
    this.timeOut,
    required this.isPresent,
    required this.attendanceDate,
    required this.schedule,
    required this.student,
  });

  factory StudentAttendancePraticeModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendancePraticeModel(
      id: map['id'] as String,
      timeIn: map['time_In'] as String,
      timeOut: map['time_out'] as String?,
      isPresent: map['isPresent'] as bool,
      attendanceDate: map['attendance_date'] as String,
      schedule: ScheduleModel.fromMap(
        map['schedule'] as Map<String, dynamic>,
      ),
      student: Student.fromMap(map['student'] as Map<String, dynamic>),
    );
  }

  factory StudentAttendancePraticeModel.fromJson(String source) =>
      StudentAttendancePraticeModel.fromMap(
        jsonDecode(source) as Map<String, dynamic>,
      );
}
