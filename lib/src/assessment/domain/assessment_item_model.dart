import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/teacher_model.dart';

class AssessmentItemModel {
  final String id;
  final String name;
  final String assessmentType;
  final String taskType;
  final String maxMark;
  final String gradingPeriod;

  final TeacherModel teacher;
  final SubjectModel subject;

  AssessmentItemModel({
    required this.id,
    required this.name,
    required this.assessmentType,
    required this.taskType,
    required this.maxMark,
    required this.gradingPeriod,
    required this.teacher,
    required this.subject,
  });

  factory AssessmentItemModel.fromMap(Map<String, dynamic> map) {
    return AssessmentItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      assessmentType: map['assessment_type'] as String,
      taskType: map['task_type'] as String,
      maxMark: map['max_marks'] as String,
      gradingPeriod: map['grading_period'] as String,
      subject: SubjectModel.fromMap(
        map['subject'] as Map<String, dynamic>,
      ),
      teacher: TeacherModel.fromMap(
        map['teacher'] as Map<String, dynamic>,
      ),
    );
  }
}
