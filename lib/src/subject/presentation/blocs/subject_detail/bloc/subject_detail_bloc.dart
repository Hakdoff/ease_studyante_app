import 'dart:async';

import 'package:ease_studyante_app/core/enum/grading_period.dart';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/assessment/data/repository/assessment_repository.dart';
import 'package:ease_studyante_app/src/assessment/domain/assessment_model.dart';
import 'package:ease_studyante_app/src/grades/domain/model/student_overall_grade_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subject_detail_event.dart';
part 'subject_detail_state.dart';

class SubjectDetailBloc extends Bloc<SubjectDetailEvent, SubjectDetailState> {
  SubjectDetailBloc({
    required this.assessmentRepository,
  }) : super(
          SubjectDetailInitial(
            assessment: const [],
            viewStatus: ViewStatus.none,
            studentOverallGrade: StudentOverallGradeModel.empty(),
          ),
        ) {
    on<GetAssessmentEvent>(_onGetAssessmentEvent);
    on<GetStudentOverallGrade>(_onGetStudentOverallGrade);
    on<GetAssessmentTeacherEvent>(_onGetAssessmentTeacherEvent);
    on<GetStudentTeacherOverallGrade>(_onGetStudentTeacherOverallGrade);
  }

  final AssessmentRepository assessmentRepository;

  FutureOr<void> _onGetAssessmentEvent(
    GetAssessmentEvent event,
    Emitter<SubjectDetailState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
    try {
      final List<GradingPeriod> gradingPeriods = [
        GradingPeriod.FIRST_GRADING,
        GradingPeriod.SECOND_GRADING,
        GradingPeriod.THIRD_GRADING,
        GradingPeriod.FOURTH_GRADING,
      ];
      List<AssessmentModel> assessments = [];

      for (var element in gradingPeriods) {
        final assessmentResponse = await assessmentRepository.getAssessment(
          gradingPeriod: element,
          subjectId: event.subjectId,
        );

        for (var element in assessmentResponse) {
          assessments.add(element);
        }
      }

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          assessment: assessments,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          assessment: [],
        ),
      );
    }
  }

  FutureOr<void> _onGetStudentOverallGrade(
    GetStudentOverallGrade event,
    Emitter<SubjectDetailState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
    try {
      final gradeResponse = await assessmentRepository.getOverallGradeStudent(
        subjectId: event.subjectId,
      );

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          studentOverallGrade: gradeResponse,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          assessment: [],
        ),
      );
    }
  }

  FutureOr<void> _onGetAssessmentTeacherEvent(
    GetAssessmentTeacherEvent event,
    Emitter<SubjectDetailState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
    try {
      final List<GradingPeriod> gradingPeriods = [
        GradingPeriod.FIRST_GRADING,
        GradingPeriod.SECOND_GRADING,
        GradingPeriod.THIRD_GRADING,
        GradingPeriod.FOURTH_GRADING,
      ];
      List<AssessmentModel> assessments = [];

      for (var element in gradingPeriods) {
        final assessmentResponse =
            await assessmentRepository.getAssessmentTeacher(
          gradingPeriod: element,
          studentId: event.studentId,
        );

        for (var element in assessmentResponse) {
          assessments.add(element);
        }
      }

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          assessment: assessments,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          assessment: [],
        ),
      );
    }
  }

  FutureOr<void> _onGetStudentTeacherOverallGrade(
    GetStudentTeacherOverallGrade event,
    Emitter<SubjectDetailState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
    try {
      final gradeResponse =
          await assessmentRepository.getOverallGradeStudentTeacher(
        subjectId: event.subjectId,
        studentId: event.studentId,
      );

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          studentOverallGrade: gradeResponse,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          assessment: [],
        ),
      );
    }
  }
}
