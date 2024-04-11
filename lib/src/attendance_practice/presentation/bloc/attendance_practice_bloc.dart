import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';

import 'package:ease_studyante_app/src/attendance_practice/data/repository/attendance_practice_repository.dart';
import 'package:ease_studyante_app/src/attendance_practice/domain/models/student_attendance_practice_model.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/bloc/attendance_practice_event.dart';
import 'package:ease_studyante_app/src/attendance_practice/presentation/bloc/attendance_practice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePracticeBloc
    extends Bloc<AttendancePracticeEvent, AttendancePracticeState> {
  AttendancePracticeBloc({
    required this.attendancePracticeRepository,
  }) : super(
          const AttendancePracticeInitial(
            viewStatus: ViewStatus.none,
            studentAttendancePractice: [],
          ),
        ) {
    on<GetStudentAttendancePracticeEvent>(_onGetStudentAttendanceEvent);
  }

  final AttendancePracticeRepository attendancePracticeRepository;

  FutureOr<void> _onGetStudentAttendanceEvent(
    GetStudentAttendancePracticeEvent event,
    Emitter<AttendancePracticeState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    try {
      final response = await attendancePracticeRepository
          .getStudentAttendancePracticeModel(event.subject.id);
      final List<StudentAttendancePraticeModel> finalList = [];
      for (var element in response) {
        if (element.schedule.subject.code == event.subject.code) {
          finalList.add(element);
        }
      }
      emit(
        state.copyWith(
          studentAttendancePractice: finalList,
          viewStatus: ViewStatus.successful,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          studentAttendancePractice: [],
          viewStatus: ViewStatus.failed,
        ),
      );
    }
  }
}
