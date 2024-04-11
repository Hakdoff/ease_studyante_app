part of 'teacher_attendance_bloc.dart';

class TeacherAttendanceState extends Equatable {
  final ViewStatus viewStatus;
  final List<StudentAttendanceModel> studentAttendance;

  const TeacherAttendanceState({
    required this.viewStatus,
    required this.studentAttendance,
  });

  TeacherAttendanceState copyWith({
    ViewStatus? viewStatus,
    List<StudentAttendanceModel>? studentAttendance,
  }) {
    return TeacherAttendanceState(
      viewStatus: viewStatus ?? this.viewStatus,
      studentAttendance: studentAttendance ?? this.studentAttendance,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        studentAttendance,
      ];
}

final class TeacherAttendanceInitial extends TeacherAttendanceState {
  const TeacherAttendanceInitial({
    required super.viewStatus,
    required super.studentAttendance,
  });
}
