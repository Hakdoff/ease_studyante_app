import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/attendance/domain/models/student_attendance_model.dart';
import 'package:ease_studyante_app/src/subject/domain/entities/subject_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/home/domain/entities/student.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teacher_attendance_event.dart';
part 'teacher_attendance_state.dart';

class TeacherAttendanceBloc
    extends Bloc<TeacherAttendanceEvent, TeacherAttendanceState> {
  TeacherAttendanceBloc({
    required this.attendanceRepository,
  }) : super(
          const TeacherAttendanceInitial(
            viewStatus: ViewStatus.none,
            studentAttendance: [],
          ),
        ) {
    on<GetTeacherStudentAttendanceEvent>(_onGetTeacherStudentAttendanceEvent);
  }

  final TeacherAttendanceRepository attendanceRepository;

  FutureOr<void> _onGetTeacherStudentAttendanceEvent(
    GetTeacherStudentAttendanceEvent event,
    Emitter<TeacherAttendanceState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    try {
      final response = await attendanceRepository.getStudentAttendance(
        subjectId: event.subject.id,
        studentId: event.student.user.pk,
      );
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
