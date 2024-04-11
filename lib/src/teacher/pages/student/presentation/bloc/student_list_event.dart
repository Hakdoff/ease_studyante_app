part of 'student_list_bloc.dart';

abstract class StudentListEvent extends Equatable {
  const StudentListEvent();

  @override
  List<Object> get props => [];
}

class OnGetTeacherStudentList extends StudentListEvent {
  final String section;

  const OnGetTeacherStudentList({
    required this.section,
  });

  @override
  List<Object> get props => [
        section,
      ];
}

class OnPaginateTeacherStudentList extends StudentListEvent {
  final String section;

  const OnPaginateTeacherStudentList({
    required this.section,
  });

  @override
  List<Object> get props => [
        section,
      ];
}
