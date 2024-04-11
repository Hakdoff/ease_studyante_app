import 'dart:async';
import 'package:ease_studyante_app/core/enum/view_status.dart';
import 'package:ease_studyante_app/src/chat/data/repository/chat_repository.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/data/models/chat_model.dart';
import 'package:ease_studyante_app/src/teacher/pages/chat/domain/entities/chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;

  ChatBloc(this._repository)
      : super(ChatInitial(
          chatModel: ChatModel.empty(),
        )) {
    on<OnTryConnectToWebSocket>(_onTryConnectToWebSocket);

    on<OnGetInitialChat>(_onGetInitialChat);
    on<OnReceivedMessageChat>(_onReceivedMessageChat);
    on<OnGetConnectWebSocket>(_onGetConnectWebSocket);
  }

  FutureOr<void> _onTryConnectToWebSocket(
    OnTryConnectToWebSocket event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
  }

  FutureOr<void> _onGetConnectWebSocket(
    OnGetConnectWebSocket event,
    Emitter<ChatState> emit,
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
    Emitter<ChatState> emit,
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
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.loading,
      ),
    );

    emit(
      state.copyWith(
        viewStatus: ViewStatus.successful,
      ),
    );

    // try {
    //   final response =
    //       await attendanceRepository.getStudentAttendance(event.subject.id);
    //   final List<StudentAttendanceModel> finalList = [];
    //   for (var element in response) {
    //     if (element.schedule.subject.code == event.subject.code) {
    //       finalList.add(element);
    //     }
    //   }
    //   emit(
    //     state.copyWith(
    //       studentAttendance: finalList,
    //       viewStatus: ViewStatus.successful,
    //     ),
    //   );
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       studentAttendance: [],
    //       viewStatus: ViewStatus.failed,
    //     ),
    //   );
    // }
  }
}
