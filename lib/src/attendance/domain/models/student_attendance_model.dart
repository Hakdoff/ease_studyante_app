import 'dart:convert';

import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';

class StudentAttendanceModel {
  final String id;
  final String? timeIn;
  final String? timeOut;
  final bool isPresent;
  final String attendanceDate;
  final ScheduleModel schedule;
  final Student student;

  StudentAttendanceModel({
    required this.id,
    required this.timeIn,
    required this.isPresent,
    required this.attendanceDate,
    required this.schedule,
    required this.student,
    this.timeOut,
  });

  factory StudentAttendanceModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendanceModel(
      id: map['id'] as String,
      timeIn: map['time_in'] as String?,
      timeOut: map['time_out'] as String?,
      isPresent: map['is_present'] as bool,
      attendanceDate: map['attendance_date'] as String,
      schedule: ScheduleModel.fromMap(
        map['schedule'] as Map<String, dynamic>,
      ),
      student: Student.fromMap(
        map['student'] as Map<String, dynamic>,
      ),
    );
  }

  factory StudentAttendanceModel.fromJson(String source) =>
      StudentAttendanceModel.fromMap(
        jsonDecode(source) as Map<String, dynamic>,
      );
}
