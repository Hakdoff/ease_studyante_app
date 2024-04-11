part of 'subject_bloc.dart';

sealed class SubjectEvent extends Equatable {}

class GetStudentSchedule extends SubjectEvent {
  GetStudentSchedule();

  @override
  List<Object?> get props => [];
}
