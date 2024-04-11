import 'package:ease_studyante_app/core/config/app_constant.dart';
import 'package:ease_studyante_app/core/interceptor/api_interceptor.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/attendance.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/data/models/qr_code_response_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/domain/repositories/qr_repository.dart';

class QRRepositoryImpl extends QRRepository {
  @override
  Future<QrCodeResponseModel> qrScanStudent(String id) async {
    const String url = '${AppConstant.apiUrl}/qr_code/';

    final data = {"student": id};

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      final attendace = Attendance.fromMap(value.data);
      final errorMessage = value.data['error_message'];

      return QrCodeResponseModel(
        attendance: attendace,
        errorMessage: errorMessage,
      );
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
