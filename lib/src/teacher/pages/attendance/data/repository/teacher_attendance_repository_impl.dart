import 'package:dio/dio.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/domain/models/attendance_timeout_model.dart';

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

  @override
  Future<List<AttendanceTimeOutModel>> getStudentTimeoutList({
    required String scheduleId,
  }) async {
    String url =
        '${AppConstant.apiUrl}/teacher/attendance/timeout?schedule_id=$scheduleId';

    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final result = value.data['results'] as List;

      final List<AttendanceTimeOutModel> attendance = [];
      for (var element in result) {
        final response = AttendanceTimeOutModel.fromMap(
          element as Map<String, dynamic>,
        );
        attendance.add(response);
      }
      return attendance;
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

  @override
  Future<List<AttendanceTimeOutModel>> postStudentTimeoutList({
    required String scheduleId,
    required List<String> studentIds,
  }) async {
    String url =
        '${AppConstant.apiUrl}/teacher/attendance/timeout?schedule_id=$scheduleId';

    Map<String, dynamic> data = {
      'student_ids': studentIds,
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      final result = value.data as List;

      final List<AttendanceTimeOutModel> attendance = [];
      for (var element in result) {
        final response = AttendanceTimeOutModel.fromMap(
          element as Map<String, dynamic>,
        );
        attendance.add(response);
      }
      return attendance;
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
