import 'package:ease_studyante_app/src/teacher/pages/qr_code/data/models/qr_code_response_model.dart';

abstract class QRRepository {
  Future<QrCodeResponseModel> qrScanStudent(String id);
}
