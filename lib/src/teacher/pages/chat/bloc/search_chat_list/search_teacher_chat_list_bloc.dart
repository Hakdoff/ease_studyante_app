import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/student/data/models/student_list_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_teacher_chat_list_event.dart';
part 'search_teacher_chat_list_state.dart';

class SearchTeacherChatListBloc
    extends Bloc<SearchTeacherChatListEvent, SearchTeacherChatListState> {
  final TeacherChatRepository _repository;
  SearchTeacherChatListBloc(this._repository)
      : super(SearchTeacherChatListInitial(
            studentList: StudentListResponseModel.empty())) {
    on<OnSearchStudentEvent>(_onSearchStudentEvent);
    on<OnPaginateSearchStudentEventt>(_onPaginateSearchStudentEventt);
  }

  FutureOr<void> _onSearchStudentEvent(
    OnSearchStudentEvent event,
    Emitter<SearchTeacherChatListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(viewStatus: ViewStatus.loading),
      );

      final response = await _repository.searchStudentChatList(q: event.q);

      emit(
        state.copyWith(
          studentList: response,
          viewStatus: ViewStatus.successful,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  FutureOr<void> _onPaginateSearchStudentEventt(
    OnPaginateSearchStudentEventt event,
    Emitter<SearchTeacherChatListState> emit,
  ) async {
    final state = this.state;

    if (state.studentList.nextPage != null &&
        state.viewStatus == ViewStatus.successful) {
      try {
        emit(
          state.copyWith(viewStatus: ViewStatus.isPaginated),
        );

        final response = await _repository.searchStudentChatList(
          q: event.q,
          next: state.studentList.nextPage,
        );

        emit(
          state.copyWith(
            studentList: response.copyWith(
              students: [
                ...state.studentList.students,
                ...response.students,
              ],
            ),
            viewStatus: ViewStatus.successful,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            viewStatus: ViewStatus.failed,
            errorMessage: 'Something went wrong',
          ),
        );
      }
    }
  }
}