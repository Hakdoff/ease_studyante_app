import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/data/models/student_list_response_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/domain/repositories/student_list_reopsitory.dart';

class StudentListRepositoryImpl extends StudentListRepository {
  @override
  Future<StudentListResponseModel> getStudentList(
      {required String section, String? next}) async {
    final String url =
        '${AppConstant.apiUrl}/teacher/registered/students?section=$section';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      return StudentListResponseModel.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
