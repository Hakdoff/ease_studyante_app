import 'package:dio/dio.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/schedule/repository/schedule_repository.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final Dio dio = Dio();

  @override
  Future<List<ScheduleModel>> getStudentSchedule() async {
    String url = '${AppConstant.apiUrl}/student/schedule';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final result = value.data['results'] as List;

      final List<ScheduleModel> schedule = [];
      for (var element in result) {
        final response = ScheduleModel.fromMap(
          element as Map<String, dynamic>,
        );
        schedule.add(response);
      }
      return schedule;
    }).onError((Response<dynamic> error, stackTrace) {
      throw {
        'status': error.statusCode.toString(),
        'data': error.data,
      };
    }).catchError((onError) {
      final error = onError as DioException;

      if (error.response != null && error.response!.data != null) {
        throw {
          'status': error.response?.statusCode ?? '400',
          'data': error.response!.data,
        };
      }

      throw error;
    });
  }
}
