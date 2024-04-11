import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';

class TeacherScheduleModel extends Equatable {
  final String? nextPage;
  final int totalCount;
  final List<TeacherSchedule> schedules;

  const TeacherScheduleModel({
    this.nextPage,
    required this.totalCount,
    required this.schedules,
  });

  @override
  List<Object?> get props => [nextPage, totalCount, schedules];
}
