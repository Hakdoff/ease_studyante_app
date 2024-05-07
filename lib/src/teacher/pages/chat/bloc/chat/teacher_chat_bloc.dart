import 'dart:async';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat_session.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/repositories/teacher_chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teacher_chat_event.dart';
part 'teacher_chat_state.dart';

class TeacherChatBloc extends Bloc<TeacherChatEvent, TeacherChatState> {
  final TeacherChatRepository _repository;

  TeacherChatBloc(this._repository)
      : super(TeacherChatInitial(
          chatModel: ChatModel.empty(),
        )) {
    on<OnTryConnectToWebSocket>(_onTryConnectToWebSocket);
    on<OnGetInitialChat>(_onGetInitialChat);
    on<OnReceivedMessageChat>(_onReceivedMessageChat);
    on<OnGetConnectWebSocket>(_onGetConnectWebSocket);
    on<OnPaginateChat>(_onPaginateChat);
  }

  FutureOr<void> _onTryConnectToWebSocket(
    OnTryConnectToWebSocket event,
    Emitter<TeacherChatState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
  }

  FutureOr<void> _onPaginateChat(
    OnPaginateChat event,
    Emitter<TeacherChatState> emit,
  ) async {
    if (state.viewStatus != ViewStatus.isPaginated &&
        state.chatModel.nextPage != null) {
      final chatModel = await _repository.getChats(
          sessionId: state.chatSession?.id ?? '',
          next: state.chatModel.nextPage);
      emit(
        state.copyWith(
            viewStatus: ViewStatus.isPaginated,
            chatModel: chatModel.copyWith(
                chats: [...state.chatModel.chats, ...chatModel.chats])),
      );
    }
  }

  FutureOr<void> _onGetConnectWebSocket(
    OnGetConnectWebSocket event,
    Emitter<TeacherChatState> emit,
  ) async {
    emit(
      state.copyWith(
        isWebSocketConnected: event.isConnected,
        viewStatus: ViewStatus.successful,
      ),
    );
  }

  FutureOr<void> _onReceivedMessageChat(
    OnReceivedMessageChat event,
    Emitter<TeacherChatState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          chatModel: state.chatModel.copyWith(
            chats: [Chat.fromJson(event.message), ...state.chatModel.chats],
          ),
        ),
      );
    } catch (e) {
      // handle error when trying to parse the message
    }
  }

  FutureOr<void> _onGetInitialChat(
    OnGetInitialChat event,
    Emitter<TeacherChatState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    ChatSession? chatSession;

    try {
      chatSession = event.chatSession == null
          ? await _repository.getChatSession(event.roomName)
          : event.chatSession!;
    } catch (e) {
      chatSession = await _repository.createChatSession(
        roomName: event.roomName,
        personId: event.personId,
        teacherId: event.teacherId,
      );
    }

    final chatModel = await _repository.getChats(
      sessionId: chatSession.id,
    );

    emit(
      state.copyWith(
        viewStatus: ViewStatus.successful,
        chatSession: chatSession,
        chatModel: chatModel,
      ),
    );
  }
}
