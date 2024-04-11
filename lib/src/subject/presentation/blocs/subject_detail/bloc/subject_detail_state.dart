part of 'subject_detail_bloc.dart';

class SubjectDetailState extends Equatable {
  final ViewStatus viewStatus;
  final List<AssessmentModel> assessment;
  final StudentOverallGradeModel studentOverallGrade;

  const SubjectDetailState({
    required this.viewStatus,
    required this.assessment,
    required this.studentOverallGrade,
  });

  SubjectDetailState copyWith({
    ViewStatus? viewStatus,
    List<AssessmentModel>? assessment,
    StudentOverallGradeModel? studentOverallGrade,
  }) {
    return SubjectDetailState(
      viewStatus: viewStatus ?? this.viewStatus,
      assessment: assessment ?? this.assessment,
      studentOverallGrade: studentOverallGrade ?? this.studentOverallGrade,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        assessment,
        studentOverallGrade,
      ];
}

final class SubjectDetailInitial extends SubjectDetailState {
  const SubjectDetailInitial({
    required super.viewStatus,
    required super.assessment,
    required super.studentOverallGrade,
  });
}
