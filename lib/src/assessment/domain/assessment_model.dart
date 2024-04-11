import 'package:ease_studyante_app/src/assessment/domain/assessment_item_model.dart';

class AssessmentModel {
  final String obtainedMarks;
  final AssessmentItemModel assessment;

  AssessmentModel({
    required this.obtainedMarks,
    required this.assessment,
  });

  factory AssessmentModel.fromMap(Map<String, dynamic> map) {
    return AssessmentModel(
      obtainedMarks: map['obtained_marks'] as String,
      assessment: AssessmentItemModel.fromMap(
        map['assessment'] as Map<String, dynamic>,
      ),
    );
  }
}
