import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/attendance.dart';
import 'package:equatable/equatable.dart';

abstract class QrPracticceScannerState extends Equatable {
  const QrPracticceScannerState();

  @override
  List<Object?> get props => [];
}

class QrPracticeScannerInitial extends QrPracticceScannerState {}

class QrPracticeScannerLoading extends QrPracticceScannerState {}

class QrPracticeScannerLoaded extends QrPracticceScannerState {
  final Attendance attendance;
  final String? errorMessage;

  const QrPracticeScannerLoaded({
    required this.attendance,
    this.errorMessage,
  });

  QrPracticeScannerLoaded copyWith({
    Attendance? attendance,
    String? errorMessage,
  }) {
    return QrPracticeScannerLoaded(
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

class QrPracticeErrorState extends QrPracticceScannerState {
  final String errorMessage;

  const QrPracticeErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
