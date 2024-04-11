import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/domain/entities/teacher.dart';
import 'package:ease_studyante_app/src/teacher/pages/profile/domain/repositories/teacher_profile_repository.dart';

class TeacherProfileRepositoryImpl extends TeacherProfileRepository {
  @override
  Future<Teacher> getTeacherProfile() async {
    const String url = '${AppConstant.apiUrl}/teacher/profile';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final response = Teacher.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
