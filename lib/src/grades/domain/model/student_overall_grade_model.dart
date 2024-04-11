class StudentOverallGradeModel {
  final String firstGrading;
  final String secondGrading;
  final String thirdGrading;
  final String fourthGrading;
  final String? totalGpa;
  final bool isViewGrade;

  StudentOverallGradeModel({
    required this.firstGrading,
    required this.secondGrading,
    required this.thirdGrading,
    required this.fourthGrading,
    required this.totalGpa,
    required this.isViewGrade,
  });

  factory StudentOverallGradeModel.fromMap(Map<String, dynamic> map) {
    return StudentOverallGradeModel(
      firstGrading: map['first_grading'] as String,
      secondGrading: map['second_grading'] as String,
      thirdGrading: map['third_grading'] as String,
      fourthGrading: map['fourth_grading'] as String,
      totalGpa: map['total_gpa'] as String? ?? 'N/A',
      isViewGrade: map['is_view_grade'] as bool,
    );
  }

  factory StudentOverallGradeModel.empty() {
    return StudentOverallGradeModel(
      firstGrading: '',
      secondGrading: '',
      thirdGrading: '',
      fourthGrading: '',
      totalGpa: '',
      isViewGrade: false,
    );
  }
}
