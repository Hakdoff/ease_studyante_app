import 'package:ease_studyante_app/src/subject/domain/entities/department_model.dart';

class SubjectModel {
  final String id;
  final DepartmentModel department;
  final String name;
  final String code;
  final String yearLevel;
  final int writtenWork;
  final int performanceTask;
  final int quarteryAssessment;

  SubjectModel({
    required this.id,
    required this.department,
    required this.name,
    required this.code,
    required this.yearLevel,
    required this.writtenWork,
    required this.performanceTask,
    required this.quarteryAssessment,
  });

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] as String,
      department: DepartmentModel.fromMap(
        map['department'] as Map<String, dynamic>,
      ),
      name: map['name'] as String,
      code: map['code'] as String,
      yearLevel: map['year_level'] as String,
      writtenWork: map['written_work'] as int,
      performanceTask: map['performance_task'] as int,
      quarteryAssessment: map['quartery_assessment'] as int,
    );
  }

  factory SubjectModel.empty() {
    return SubjectModel(
      code: '',
      department: DepartmentModel.empty(),
      id: '',
      name: '',
      performanceTask: -1,
      quarteryAssessment: -1,
      writtenWork: -1,
      yearLevel: '',
    );
  }
}
