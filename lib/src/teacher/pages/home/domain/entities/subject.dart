import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/department.dart';

class Subject extends Equatable {
  final String id;
  final Department department;
  final String name;
  final String code;
  final String yearLevel;
  final int writtenWork;
  final int performanceTask;
  final int quarteryAssessment;

  const Subject({
    required this.id,
    required this.department,
    required this.name,
    required this.code,
    required this.yearLevel,
    required this.writtenWork,
    required this.performanceTask,
    required this.quarteryAssessment,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'department': department.toMap()});
    result.addAll({'name': name});
    result.addAll({'code': code});
    result.addAll({'yearLevel': yearLevel});
    result.addAll({'written_work': writtenWork});
    result.addAll({'performance_task': performanceTask});
    result.addAll({'quartery_assessment': quarteryAssessment});

    return result;
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'] ?? '',
      department: Department.fromMap(map['department']),
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      yearLevel: map['yearLevel'] ?? '',
      writtenWork: map['written_work']?.toInt() ?? 0,
      performanceTask: map['performance_task']?.toInt() ?? 0,
      quarteryAssessment: map['quartery_assessment']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));

  factory Subject.empty() {
    return Subject(
        id: '',
        department: Department.empty(),
        name: '',
        code: '',
        yearLevel: '',
        writtenWork: -1,
        performanceTask: -1,
        quarteryAssessment: -1);
  }
  @override
  List<Object> get props {
    return [
      id,
      department,
      name,
      code,
      yearLevel,
      writtenWork,
      performanceTask,
      quarteryAssessment,
    ];
  }
}
