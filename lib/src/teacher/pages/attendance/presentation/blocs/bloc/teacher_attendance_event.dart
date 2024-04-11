part of 'teacher_attendance_bloc.dart';

sealed class TeacherAttendanceEvent extends Equatable {}

class GetTeacherStudentAttendanceEvent extends TeacherAttendanceEvent {
  final SubjectModel subject;
  final Student student;

  GetTeacherStudentAttendanceEvent({
    required this.subject,
    required this.student,
  });
  @override
  List<Object?> get props => [
        subject,
        student,
      ];
}
