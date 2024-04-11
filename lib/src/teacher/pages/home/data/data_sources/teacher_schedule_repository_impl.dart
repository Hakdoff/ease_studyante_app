import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/data/models/teacher_schedule_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/teacher_schedule.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/repositories/teacher_schedule_repository.dart';

class TeacherScheduleRepositoryImpl extends TeacherScheduleRepository {
  @override
  Future<TeacherScheduleModel> getTeacherSchedules({String? nextPage}) async {
    String url = nextPage ?? '${AppConstant.apiUrl}/teacher/schedules';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      final schedules = results.map((e) => TeacherSchedule.fromMap(e)).toList();
      return TeacherScheduleModel(
          schedules: schedules,
          nextPage: value.data['next'],
          totalCount: value.data['count']);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
