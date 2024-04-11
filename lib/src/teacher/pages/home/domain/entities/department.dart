import 'dart:convert';

import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final int id;
  final String name;
  final String code;

  const Department({
    required this.id,
    required this.name,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'code': code});

    return result;
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Department.fromJson(String source) =>
      Department.fromMap(json.decode(source));

  factory Department.empty() {
    return const Department(
      id: -1,
      name: '',
      code: '',
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        code,
      ];
}
