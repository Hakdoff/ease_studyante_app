import 'dart:async';

import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/chat/data/models/chat_list_model.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_list_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatListRepository _repository;

  ChatListBloc(this._repository)
      : super(
          ChatListInitial(
            chatListModel: ChatListModel.empty(),
          ),
        ) {
    on<OnGetStudentChatList>(_onGetStudentChatList);
    on<OnPaginateStudentChatList>(_onPaginateStudentChatList);
  }

  FutureOr<void> _onGetStudentChatList(
    OnGetStudentChatList event,
    Emitter<ChatListState> emit,
  ) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final response = await _repository.getChatList();

    emit(
      state.copyWith(
        chatListModel: response,
        viewStatus: ViewStatus.successful,
      ),
    );
  }

  FutureOr<void> _onPaginateStudentChatList(
    OnPaginateStudentChatList event,
    Emitter<ChatListState> emit,
  ) async {
    if (state.viewStatus == ViewStatus.successful) {
      emit(state.copyWith(viewStatus: ViewStatus.isPaginated));

      final response =
          await _repository.getChatList(nextPage: state.chatListModel.nextPage);

      emit(
        state.copyWith(
          chatListModel: response.copyWith(
            teachers: [
              ...state.chatListModel.teachers,
              ...response.teachers,
            ],
          ),
          viewStatus: ViewStatus.successful,
        ),
      );
    }
  }
}
