import 'package:ease_studyante_app/src/qr_practice/data/models/qr_practice_response_model.dart';

abstract class QRPracticeRepository {
  Future<QrPracticeResponseModel> qrScanStudent(String id);
}
