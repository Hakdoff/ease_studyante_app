import 'package:ease_studyante_app/core/enum/grading_period.dart';
import 'package:ease_studyante_app/src/assessment/domain/assessment_model.dart';
import 'package:ease_studyante_app/src/grades/domain/model/student_overall_grade_model.dart';

abstract class AssessmentRepository {
  Future<List<AssessmentModel>> getAssessment({
    required GradingPeriod gradingPeriod,
    required String subjectId,
    required bool isParent,
    String? studentId,
  });

  Future<List<AssessmentModel>> getAssessmentTeacher({
    required GradingPeriod gradingPeriod,
    required String studentId,
  });

  Future<StudentOverallGradeModel> getOverallGradeStudent({
    required String subjectId,
    required bool isParent,
    String? studentId,
  });

  Future<StudentOverallGradeModel> getOverallGradeStudentTeacher({
    required String subjectId,
    required String studentId,
  });
}
