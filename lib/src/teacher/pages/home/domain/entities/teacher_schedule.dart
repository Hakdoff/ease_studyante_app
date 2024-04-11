import 'dart:convert';

import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';

class TeacherSchedule extends Equatable {
  final String id;
  final SubjectModel subject;
  final Section section;
  final String day;
  final String timeStart;
  final String timeEnd;

  const TeacherSchedule({
    required this.id,
    required this.subject,
    required this.section,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
  });

  @override
  List<Object> get props {
    return [
      id,
      subject,
      section,
      day,
      timeStart,
      timeEnd,
    ];
  }

  factory TeacherSchedule.fromMap(Map<String, dynamic> map) {
    return TeacherSchedule(
      id: map['id'] ?? '',
      subject: SubjectModel.fromMap(map['subject']),
      section: Section.fromMap(map['section']),
      day: map['day'] ?? '',
      timeStart: map['time_start'] ?? '',
      timeEnd: map['time_end'] ?? '',
    );
  }

  factory TeacherSchedule.fromJson(String source) =>
      TeacherSchedule.fromMap(json.decode(source));

  factory TeacherSchedule.empty() {
    return TeacherSchedule(
      day: '',
      id: '',
      section: Section.empty(),
      subject: SubjectModel.empty(),
      timeEnd: '07:00:00',
      timeStart: '07:00:00',
    );
  }
}
