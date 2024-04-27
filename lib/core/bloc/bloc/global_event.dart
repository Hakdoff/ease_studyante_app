part of 'global_bloc.dart';

sealed class GlobalEvent extends Equatable {}

class StoreStudentProfileEvent extends GlobalEvent {
  final Profile profile;
  StoreStudentProfileEvent({required this.profile});
  @override
  List<Object?> get props => [profile];
}

class StoreStudentSectionEvent extends GlobalEvent {
  final Section section;
  StoreStudentSectionEvent({required this.section});
  @override
  List<Object?> get props => [section];
}

class StoreStudentScheduleEvent extends GlobalEvent {
  final List<ScheduleModel> schedule;
  StoreStudentScheduleEvent({required this.schedule});
  @override
  List<Object?> get props => [schedule];
}
