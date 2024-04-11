part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final ViewStatus viewStatus;
  final List<StudentAttendanceModel> studentAttendance;

  const AttendanceState({
    required this.viewStatus,
    required this.studentAttendance,
  });

  AttendanceState copyWith({
    ViewStatus? viewStatus,
    List<StudentAttendanceModel>? studentAttendance,
  }) {
    return AttendanceState(
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

final class AttendanceInitial extends AttendanceState {
  const AttendanceInitial({
    required super.viewStatus,
    required super.studentAttendance,
  });
}
