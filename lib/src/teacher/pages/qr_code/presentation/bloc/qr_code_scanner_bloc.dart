import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/attendance.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/domain/repositories/qr_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_code_scanner_event.dart';
part 'qr_code_scanner_state.dart';

class QrCodeScannerBloc extends Bloc<QrCodeScannerEvent, QrCodeScannerState> {
  final QRRepository repository;

  QrCodeScannerBloc(this.repository) : super(QrCodeScannerInitial()) {
    on<OnQRScanEvent>(onQRScanEvent);
  }

  Future<void> onQRScanEvent(
      OnQRScanEvent event, Emitter<QrCodeScannerState> emit) async {
    final state = this.state;

    if (state is! QrCodeScannerLoading) {
      emit(QrCodeScannerLoading());

      try {
        final response = await repository.qrScanStudent(event.id);

        emit(
          QrCodeScannerLoaded(
            attendance: response.attendance,
            errorMessage: response.errorMessage,
          ),
        );
      } catch (e) {
        final error = e as DioException;
        final response = error.response?.data['error_message'];
        emit(QrCodeErrorState(errorMessage: response));
      }
    }
  }
}
