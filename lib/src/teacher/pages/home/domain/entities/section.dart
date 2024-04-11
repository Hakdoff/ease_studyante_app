import 'dart:convert';

import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String id;
  final String name;
  final String yearLevel;

  const Section({
    required this.id,
    required this.name,
    required this.yearLevel,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'yearLevel': yearLevel});

    return result;
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      yearLevel: map['year_level'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(String source) =>
      Section.fromMap(json.decode(source));

  factory Section.empty() {
    return const Section(
      id: '',
      name: '',
      yearLevel: '',
    );
  }

  @override
  List<Object> get props => [id, name, yearLevel];
}
