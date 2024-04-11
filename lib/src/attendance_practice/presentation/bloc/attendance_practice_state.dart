import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/attendance_practice/domain/models/student_attendance_practice_model.dart';
import 'package:equatable/equatable.dart';

class AttendancePracticeState extends Equatable {
  final ViewStatus viewStatus;
  final List<StudentAttendancePraticeModel> studentAttendancePractice;

  const AttendancePracticeState({
    required this.viewStatus,
    required this.studentAttendancePractice,
  });

  AttendancePracticeState copyWith({
    ViewStatus? viewStatus,
    List<StudentAttendancePraticeModel>? studentAttendancePractice,
  }) {
    return AttendancePracticeState(
      viewStatus: viewStatus ?? this.viewStatus,
      studentAttendancePractice:
          studentAttendancePractice ?? this.studentAttendancePractice,
    );
  }

  @override
  List<Object> get props => [viewStatus, studentAttendancePractice];
}

final class AttendancePracticeInitial extends AttendancePracticeState {
  const AttendancePracticeInitial({
    required super.viewStatus,
    required super.studentAttendancePractice,
  });
}
