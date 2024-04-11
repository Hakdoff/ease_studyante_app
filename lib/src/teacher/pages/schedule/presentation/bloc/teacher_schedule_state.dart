part of 'teacher_schedule_bloc.dart';

abstract class TeacherScheduleState extends Equatable {
  const TeacherScheduleState();

  @override
  List<Object> get props => [];
}

class TeacherScheduleInitial extends TeacherScheduleState {}

class TeacherScheduleLoading extends TeacherScheduleState {}

class TeacherScheduleError extends TeacherScheduleState {
  final String errorMessage;

  const TeacherScheduleError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class TeacherScheduleLoaded extends TeacherScheduleState {
  final TeacherScheduleModel teacherScheduleModel;
  final bool isPaginate;

  const TeacherScheduleLoaded({
    required this.teacherScheduleModel,
    this.isPaginate = false,
  });

  @override
  List<Object> get props => [
        teacherScheduleModel,
        isPaginate,
      ];

  TeacherScheduleLoaded copyWith({
    TeacherScheduleModel? teacherScheduleModel,
    bool? isPaginate,
  }) {
    return TeacherScheduleLoaded(
      teacherScheduleModel: teacherScheduleModel ?? this.teacherScheduleModel,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }
}
