part of 'subject_bloc.dart';

sealed class SubjectEvent extends Equatable {}

class GetStudentSchedule extends SubjectEvent {
  final bool isParent;
  final String? studentId;
  GetStudentSchedule({
    required this.isParent,
    this.studentId,
  });

  @override
  List<Object?> get props => [isParent];
}
