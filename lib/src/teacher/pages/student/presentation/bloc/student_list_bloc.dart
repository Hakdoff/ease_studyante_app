import 'dart:async';

import 'package:ease_studyante_app/src/teacher/pages/attendance/data/repository/teacher_attendance_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/attendance/domain/models/attendance_timeout_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/data/models/student_list_response_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/domain/repositories/student_list_reopsitory.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_list_event.dart';
part 'student_list_state.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  final StudentListRepository repository;
  final TeacherAttendanceRepository teacherAttendanceRepository;

  StudentListBloc(
    this.repository,
    this.teacherAttendanceRepository,
  ) : super(StudentListInitial()) {
    on<OnGetTeacherStudentList>(onGetTeacherStudentList);
    on<OnPaginateTeacherStudentList>(onPaginateTeacherStudentList);
    on<PostStudentAttendanceTimeout>(_onPostStudentAttendanceTimeout);
  }

  Future<void> onGetTeacherStudentList(
      OnGetTeacherStudentList event, Emitter<StudentListState> emit) async {
    emit(StudentListLoading());
    try {
      final response = await repository.getStudentList(section: event.section);
      final attendanceResponse =
          await teacherAttendanceRepository.getStudentTimeoutList(
        scheduleId: event.teacherScheduleId,
      );

      emit(
        StudentListLoaded(
          studentList: response,
          studentTimeOut: attendanceResponse,
        ),
      );
    } catch (e) {
      emit(StudentListError(errorMessage: e.toString()));
    }
  }

  Future<void> onPaginateTeacherStudentList(
    OnPaginateTeacherStudentList event,
    Emitter<StudentListState> emit,
  ) async {
    final state = this.state;

    if (state is StudentListLoaded &&
        state.studentList.nextPage != null &&
        !state.isPaginate) {
      emit(state.copyWith(isPaginate: true));

      try {
        final response = await repository.getStudentList(
            section: event.section, next: state.studentList.nextPage);

        final attendanceResponse =
            await teacherAttendanceRepository.getStudentTimeoutList(
          scheduleId: event.teacherScheduleId,
        );
        emit(
          state.copyWith(
            studentList: response.copyWith(
              students: [...state.studentList.students, ...response.students],
            ),
            studentTimeOut: attendanceResponse,
            isPaginate: false,
          ),
        );
      } catch (e) {
        emit(StudentListError(errorMessage: e.toString()));
      }
    }
  }

  FutureOr<void> _onPostStudentAttendanceTimeout(
    PostStudentAttendanceTimeout event,
    Emitter<StudentListState> emit,
  ) async {
    emit(StudentListLoading());
    try {
      final response = await teacherAttendanceRepository.postStudentTimeoutList(
        scheduleId: event.section,
        studentIds: event.studentIds,
      );

      emit(
        PostStudentTimeOutSuccessState(),
      );
    } catch (e) {
      emit(StudentListError(errorMessage: e.toString()));
    }
  }
}
