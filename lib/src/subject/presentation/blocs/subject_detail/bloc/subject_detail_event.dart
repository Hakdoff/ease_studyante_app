part of 'subject_detail_bloc.dart';

sealed class SubjectDetailEvent extends Equatable {}

class GetAssessmentEvent extends SubjectDetailEvent {
  final String subjectId;
  final bool isParent;
  final String? studentId;

  GetAssessmentEvent({
    required this.subjectId,
    required this.isParent,
    this.studentId,
  });

  @override
  List<Object?> get props => [
        subjectId,
        isParent,
        studentId,
      ];
}

class GetAssessmentTeacherEvent extends SubjectDetailEvent {
  final String studentId;

  GetAssessmentTeacherEvent({
    required this.studentId,
  });

  @override
  List<Object?> get props => [studentId];
}

class GetStudentOverallGrade extends SubjectDetailEvent {
  final String subjectId;
  final bool isParent;
  final String? studentId;

  GetStudentOverallGrade({
    required this.subjectId,
    required this.isParent,
    this.studentId,
  });

  @override
  List<Object?> get props => [
        subjectId,
        isParent,
        studentId,
      ];
}

class GetStudentTeacherOverallGrade extends SubjectDetailEvent {
  final String subjectId;
  final String studentId;

  GetStudentTeacherOverallGrade({
    required this.subjectId,
    required this.studentId,
  });

  @override
  List<Object?> get props => [
        subjectId,
        studentId,
      ];
}
