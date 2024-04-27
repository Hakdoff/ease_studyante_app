import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/profile/domain/entities/profile.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/schedule_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/section.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc()
      : super(
          GlobalInitial(
            studentProfile: Profile.empty(),
            viewStatus: ViewStatus.none,
            studentSection: Section.empty(),
            studentSchedule: const [],
          ),
        ) {
    on<StoreStudentProfileEvent>(_onStoreStudentProfileEvent);
    on<StoreStudentSectionEvent>(_onStoreStudentSectionEvent);
    on<StoreStudentScheduleEvent>(_onStoreStudentScheduleEvent);
  }

  FutureOr<void> _onStoreStudentProfileEvent(
    StoreStudentProfileEvent event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        studentProfile: event.profile,
      ),
    );
  }

  FutureOr<void> _onStoreStudentSectionEvent(
    StoreStudentSectionEvent event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        studentSection: event.section,
      ),
    );
  }

  FutureOr<void> _onStoreStudentScheduleEvent(
    StoreStudentScheduleEvent event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      state.copyWith(
        studentSchedule: event.schedule,
      ),
    );
  }
}
