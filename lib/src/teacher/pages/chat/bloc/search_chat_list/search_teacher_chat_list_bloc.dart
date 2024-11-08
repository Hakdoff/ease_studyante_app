import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/user_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_teacher_chat_list_event.dart';
part 'search_teacher_chat_list_state.dart';

class SearchTeacherChatListBloc
    extends Bloc<SearchTeacherChatListEvent, SearchTeacherChatListState> {
  final TeacherChatRepository _repository;
  SearchTeacherChatListBloc(this._repository)
      : super(SearchTeacherChatListInitial(
            userListResponseModel: UserListResponseModel.empty())) {
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

      final response = await _repository.searchUserChatList(q: event.q);

      emit(
        state.copyWith(
          userListResponseModel: response,
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

    if (state.userListResponseModel.nextPage != null &&
        state.viewStatus == ViewStatus.successful) {
      try {
        emit(
          state.copyWith(viewStatus: ViewStatus.isPaginated),
        );

        final response = await _repository.searchUserChatList(
          q: event.q,
          next: state.userListResponseModel.nextPage,
        );

        emit(
          state.copyWith(
            userListResponseModel: response.copyWith(
              users: [
                ...state.userListResponseModel.users,
                ...response.users,
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
