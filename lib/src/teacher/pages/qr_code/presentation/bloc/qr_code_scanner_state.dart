part of 'qr_code_scanner_bloc.dart';

abstract class QrCodeScannerState extends Equatable {
  const QrCodeScannerState();

  @override
  List<Object?> get props => [];
}

class QrCodeScannerInitial extends QrCodeScannerState {}

class QrCodeScannerLoading extends QrCodeScannerState {}

class QrCodeScannerLoaded extends QrCodeScannerState {
  final Attendance attendance;
  final String? errorMessage;

  const QrCodeScannerLoaded({
    required this.attendance,
    this.errorMessage,
  });

  QrCodeScannerLoaded copyWith({
    Attendance? attendance,
    String? errorMessage,
  }) {
    return QrCodeScannerLoaded(
      attendance: attendance ?? this.attendance,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        attendance,
        errorMessage,
      ];
}

class QrCodeErrorState extends QrCodeScannerState {
  final String errorMessage;

  const QrCodeErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
