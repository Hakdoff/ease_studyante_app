import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/attendance.dart';
import 'package:equatable/equatable.dart';

class QrPracticeResponseModel extends Equatable {
  final Attendance attendance;
  final String? errorMessage;

  const QrPracticeResponseModel({
    required this.attendance,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        attendance,
        errorMessage,
      ];
}
