import 'package:ease_studyante_app/src/teacher/pages/home/data/models/teacher_schedule_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/repositories/teacher_schedule_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teacher_schedule_event.dart';
part 'teacher_schedule_state.dart';

class TeacherScheduleBloc
    extends Bloc<TeacherScheduleEvent, TeacherScheduleState> {
  final TeacherScheduleRepository repository;

  TeacherScheduleBloc(this.repository) : super(TeacherScheduleInitial()) {
    on<OnGetTeacherScheduleEvent>(onGetTeacherScheduleEvent);
  }

  Future<void> onGetTeacherScheduleEvent(OnGetTeacherScheduleEvent event,
      Emitter<TeacherScheduleState> emit) async {
    emit(TeacherScheduleLoading());

    try {
      final response = await repository.getTeacherSchedules();
      emit(TeacherScheduleLoaded(teacherScheduleModel: response));
    } catch (e) {
      emit(TeacherScheduleError(errorMessage: e.toString()));
    }
  }
}
