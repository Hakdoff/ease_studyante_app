import 'package:ease_studyante_app/src/qr_practice/domain/repositories/qr_practice_repository.dart';
import 'package:ease_studyante_app/src/qr_practice/presentation/bloc/qr_practice_scanner_event.dart';
import 'package:ease_studyante_app/src/qr_practice/presentation/bloc/qr_practice_scanner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QRPracticeBloc
    extends Bloc<QrPracticeScannerEvent, QrPracticceScannerState> {
  final QRPracticeRepository repository;

  QRPracticeBloc(this.repository) : super(QrPracticeScannerInitial()) {
    on<OnQrPracticeScanEvent>(onQrPracticeScanEvent);
  }

  Future<void> onQrPracticeScanEvent(OnQrPracticeScanEvent event,
      Emitter<QrPracticceScannerState> emit) async {
    final state = this.state;

    if (state is! QrPracticeScannerLoading) {
      emit(QrPracticeScannerLoading());

      final response = await repository.qrScanStudent(event.id);

      emit(
        QrPracticeScannerLoaded(
          attendance: response.attendance,
          errorMessage: response.errorMessage,
        ),
      );
    }
  }
}
