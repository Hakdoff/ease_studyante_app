class DepartmentModel {
  final int id;
  final String name;
  final String code;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.code,
  });

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    return DepartmentModel(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  factory DepartmentModel.empty() {
    return DepartmentModel(
      id: -1,
      name: '',
      code: '',
    );
  }
}
