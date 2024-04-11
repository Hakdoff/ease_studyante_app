import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:equatable/equatable.dart';

sealed class AttendancePracticeEvent extends Equatable {}

class GetStudentAttendancePracticeEvent extends AttendancePracticeEvent {
  final SubjectModel subject;
  GetStudentAttendancePracticeEvent({required this.subject});

  @override
  List<Object?> get props => [subject];
}
