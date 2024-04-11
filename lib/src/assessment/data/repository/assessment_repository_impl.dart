import 'package:dio/dio.dart';
import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/enum/grading_period.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/assessment/data/repository/assessment_repository.dart';
import 'package:ease_studyante_app/src/assessment/domain/assessment_model.dart';
import 'package:ease_studyante_app/src/grades/domain/model/student_overall_grade_model.dart';

class AssessmentRepositoryImpl extends AssessmentRepository {
  @override
  Future<List<AssessmentModel>> getAssessment({
    required GradingPeriod gradingPeriod,
    required String subjectId,
  }) async {
    final gradingPeriodParsed =
        gradingPeriod.toString().replaceAll('GradingPeriod.', '');
    String url =
        '${AppConstant.apiUrl}/student/assessments?grading_period=$gradingPeriodParsed&subject_id=$subjectId&limit=100';

    return await ApiInterceptor.apiInstance().get(url).then(
      (value) {
        final result = value.data['results'] as List;

        final List<AssessmentModel> assessment = [];
        for (var element in result) {
          final response = AssessmentModel.fromMap(
            element as Map<String, dynamic>,
          );
          assessment.add(response);
        }
        return assessment;
      },
    ).onError(
      (Response<dynamic> error, stackTrace) {
        throw {
          'status': error.statusCode.toString(),
          'data': error.data,
        };
      },
    ).catchError(
      (onError) {
        final error = onError as DioException;

        if (error.response != null && error.response!.data != null) {
          throw {
            'status': error.response?.statusCode ?? '400',
            'data': error.response!.data,
          };
        }

        throw error;
      },
    );
  }

  @override
  Future<StudentOverallGradeModel> getOverallGradeStudent(
      {required String subjectId}) async {
    String url = '${AppConstant.apiUrl}/student/over-all?subject_id=$subjectId';

    return await ApiInterceptor.apiInstance().get(url).then(
      (value) {
        final result = StudentOverallGradeModel.fromMap(
            value.data as Map<String, dynamic>);

        return result;
      },
    ).onError(
      (Response<dynamic> error, stackTrace) {
        throw {
          'status': error.statusCode.toString(),
          'data': error.data,
        };
      },
    ).catchError(
      (onError) {
        final error = onError as DioException;

        if (error.response != null && error.response!.data != null) {
          throw {
            'status': error.response?.statusCode ?? '400',
            'data': error.response!.data,
          };
        }

        throw error;
      },
    );
  }

  @override
  Future<List<AssessmentModel>> getAssessmentTeacher({
    required GradingPeriod gradingPeriod,
    required String studentId,
  }) async {
    final gradingPeriodParsed =
        gradingPeriod.toString().replaceAll('GradingPeriod.', '');
    String url =
        '${AppConstant.apiUrl}/teacher/assessments?grading_period=$gradingPeriodParsed&student_id=$studentId';

    return await ApiInterceptor.apiInstance().get(url).then(
      (value) {
        final result = value.data['results'] as List;

        final List<AssessmentModel> assessment = [];
        for (var element in result) {
          final response = AssessmentModel.fromMap(
            element as Map<String, dynamic>,
          );
          assessment.add(response);
        }
        return assessment;
      },
    ).onError(
      (Response<dynamic> error, stackTrace) {
        throw {
          'status': error.statusCode.toString(),
          'data': error.data,
        };
      },
    ).catchError(
      (onError) {
        final error = onError as DioException;

        if (error.response != null && error.response!.data != null) {
          throw {
            'status': error.response?.statusCode ?? '400',
            'data': error.response!.data,
          };
        }

        throw error;
      },
    );
  }

  @override
  Future<StudentOverallGradeModel> getOverallGradeStudentTeacher({
    required String subjectId,
    required String studentId,
  }) async {
    String url =
        '${AppConstant.apiUrl}/teacher/student/over-all-gpa?student_id=$studentId&subject_id=$subjectId';

    return await ApiInterceptor.apiInstance().get(url).then(
      (value) {
        final result = StudentOverallGradeModel.fromMap(
            value.data as Map<String, dynamic>);

        return result;
      },
    ).onError(
      (Response<dynamic> error, stackTrace) {
        throw {
          'status': error.statusCode.toString(),
          'data': error.data,
        };
      },
    ).catchError(
      (onError) {
        final error = onError as DioException;

        if (error.response != null && error.response!.data != null) {
          throw {
            'status': error.response?.statusCode ?? '400',
            'data': error.response!.data,
          };
        }

        throw error;
      },
    );
  }
}
