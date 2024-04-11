import 'package:ease_studyante_app/src/subject/domain/entities/user_model.dart';

class TeacherModel {
  final String pk;
  final int department;
  final String? profilePhoto;
  final UserModel user;

  TeacherModel({
    required this.pk,
    required this.department,
    this.profilePhoto,
    required this.user,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      pk: map['pk'] as String,
      department: map['department'] as int,
      profilePhoto: map['profile_photo'] as String? ?? '',
      user: UserModel.fromMap(
        map['user'] as Map<String, dynamic>,
      ),
    );
  }
}
