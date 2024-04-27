import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/schedule/repository/schedule_repository.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc({required this.scheduleRepository})
      : super(
          const SubjectInitial(
            schedule: [],
            viewStatus: ViewStatus.none,
          ),
        ) {
    on<GetStudentSchedule>(_onGetStudentSchedule);
  }

  final ScheduleRepository scheduleRepository;

  FutureOr<void> _onGetStudentSchedule(
    GetStudentSchedule event,
    Emitter<SubjectState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    try {
      final response = await scheduleRepository.getStudentSchedule(
        isParent: event.isParent,
        studentId: event.studentId,
      );

      emit(
        state.copyWith(
          schedule: response,
          viewStatus: ViewStatus.successful,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          schedule: [],
          viewStatus: ViewStatus.failed,
        ),
      );
    }
  }
}
