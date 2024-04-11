import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/qr_practice/data/models/qr_practice_response_model.dart';
import 'package:ease_studyante_app/src/qr_practice/domain/repositories/qr_practice_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/attendance.dart';

class QRPracticeRepositoryImpl extends QRPracticeRepository {
  @override
  Future<QrPracticeResponseModel> qrScanStudent(String id) async {
    const String url = '${AppConstant.apiUrl}/qr_code/';

    final data = {"student": id};

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      final attendance = Attendance.fromMap(value.data);
      final errorMessage = value.data['error_message'];

      return QrPracticeResponseModel(
        attendance: attendance,
        errorMessage: errorMessage,
      );
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
