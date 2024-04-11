part of 'teacher_bloc.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLogout extends TeacherState {}

class TeacherError extends TeacherState {
  final String errorMessage;

  const TeacherError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class TeacherLoaded extends TeacherState {
  final Teacher teacher;

  const TeacherLoaded({
    required this.teacher,
  });

  @override
  List<Object> get props => [
        teacher,
      ];
}
