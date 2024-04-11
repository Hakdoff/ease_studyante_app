part of 'teacher_bloc.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object> get props => [];
}

class OnGetTeacherProfileEvent extends TeacherEvent {}

class SetTeacherProfileEvent extends TeacherEvent {}

class OnTeacherLogout extends TeacherEvent {}
