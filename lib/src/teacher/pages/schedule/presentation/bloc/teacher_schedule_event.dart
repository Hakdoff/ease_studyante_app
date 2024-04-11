part of 'teacher_schedule_bloc.dart';

abstract class TeacherScheduleEvent extends Equatable {
  const TeacherScheduleEvent();

  @override
  List<Object> get props => [];
}

class OnGetTeacherScheduleEvent extends TeacherScheduleEvent {}

class OnPaginateTeacherScheduleEvent extends TeacherScheduleEvent {}
