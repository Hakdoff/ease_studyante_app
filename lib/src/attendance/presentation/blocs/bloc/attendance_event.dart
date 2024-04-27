part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {}

class GetStudentAttendanceEvent extends AttendanceEvent {
  final SubjectModel subject;
  final bool isParent;
  final String? studentId;
  GetStudentAttendanceEvent({
    required this.subject,
    required this.isParent,
    this.studentId,
  });
  @override
  List<Object?> get props => [
        subject,
        isParent,
        studentId,
      ];
}
