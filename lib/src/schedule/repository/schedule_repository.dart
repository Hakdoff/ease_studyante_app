import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleModel>> getStudentSchedule();
}
