part of 'student_list_bloc.dart';

abstract class StudentListEvent extends Equatable {
  const StudentListEvent();

  @override
  List<Object> get props => [];
}

class OnGetTeacherStudentList extends StudentListEvent {
  final String section;
  final String teacherScheduleId;

  const OnGetTeacherStudentList({
    required this.section,
    required this.teacherScheduleId,
  });

  @override
  List<Object> get props => [
        section,
        teacherScheduleId,
      ];
}

class OnPaginateTeacherStudentList extends StudentListEvent {
  final String section;
  final String teacherScheduleId;

  const OnPaginateTeacherStudentList({
    required this.section,
    required this.teacherScheduleId,
  });

  @override
  List<Object> get props => [
        section,
        teacherScheduleId,
      ];
}

class GetStudentAttendanceTimeout extends StudentListEvent {
  final String section;

  const GetStudentAttendanceTimeout({
    required this.section,
  });

  @override
  List<Object> get props => [
        section,
      ];
}

class PostStudentAttendanceTimeout extends StudentListEvent {
  final String section;
  final List<String> studentIds;

  const PostStudentAttendanceTimeout({
    required this.section,
    required this.studentIds,
  });

  @override
  List<Object> get props => [
        section,
        studentIds,
      ];
}
