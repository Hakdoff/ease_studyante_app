import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/attendance/data/repository/attendance_repository.dart';
import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({
    required this.attendanceRepository,
  }) : super(
          const AttendanceInitial(
            viewStatus: ViewStatus.none,
            studentAttendance: [],
          ),
        ) {
    on<GetStudentAttendanceEvent>(_onGetStudentAttendanceEvent);
  }

  final AttendanceRepository attendanceRepository;

  FutureOr<void> _onGetStudentAttendanceEvent(
    GetStudentAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    try {
      final response =
          await attendanceRepository.getStudentAttendance(event.subject.id);
      final List<StudentAttendanceModel> finalList = [];
      for (var element in response) {
        if (element.schedule.subject.code == event.subject.code) {
          finalList.add(element);
        }
      }
      emit(
        state.copyWith(
          studentAttendance: finalList,
          viewStatus: ViewStatus.successful,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          studentAttendance: [],
          viewStatus: ViewStatus.failed,
        ),
      );
    }
  }
}
