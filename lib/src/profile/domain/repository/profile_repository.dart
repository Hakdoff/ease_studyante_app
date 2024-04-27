import 'package:ease_studyante_app/src/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getUserProfile();
  Future<Profile> getStudentProfile();
  Future<Profile> getParentProfile();
  Future<void> setPushToken(String token);
}
