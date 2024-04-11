import 'package:dio/dio.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository.dart';

class TeacherAttendanceRepositoryImpl extends TeacherAttendanceRepository {
  @override
  Future<List<StudentAttendanceModel>> getStudentAttendance({
    required String studentId,
    required String subjectId,
  }) async {
    String url =
        '${AppConstant.apiUrl}/teacher/students/attendance?student_id=$studentId&subject_id=$subjectId';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final result = value.data['results'] as List;

      final List<StudentAttendanceModel> schedule = [];
      for (var element in result) {
        final response = StudentAttendanceModel.fromMap(
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
