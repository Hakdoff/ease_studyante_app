import 'package:equatable/equatable.dart';

import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/attendance.dart';

class QrCodeResponseModel extends Equatable {
  final Attendance attendance;
  final String? errorMessage;

  const QrCodeResponseModel({
    required this.attendance,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        attendance,
        errorMessage,
      ];
}
