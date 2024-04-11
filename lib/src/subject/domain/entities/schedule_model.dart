import 'dart:convert';

import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/teacher_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';

class ScheduleModel {
  final String id;
  final String days;
  final String timeStart;
  final String timeEnd;
  final SubjectModel subject;
  final TeacherModel teacher;
  final Section section;

  ScheduleModel({
    required this.id,
    required this.days,
    required this.timeStart,
    required this.timeEnd,
    required this.subject,
    required this.teacher,
    required this.section,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id'] as String,
      days: map['day'] as String,
      timeStart: map['time_start'] as String,
      timeEnd: map['time_end'] as String,
      subject: SubjectModel.fromMap(
        map['subject'] as Map<String, dynamic>,
      ),
      teacher: TeacherModel.fromMap(
        map['teacher'] as Map<String, dynamic>,
      ),
      section: Section.fromMap(
        map['section'] as Map<String, dynamic>,
      ),
    );
  }

  factory ScheduleModel.fromJson(String source) => ScheduleModel.fromMap(
        jsonDecode(source) as Map<String, dynamic>,
      );
}
