part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {}

class GetStudentAttendanceEvent extends AttendanceEvent {
  final SubjectModel subject;
  GetStudentAttendanceEvent({required this.subject});
  @override
  List<Object?> get props => [subject];
}
