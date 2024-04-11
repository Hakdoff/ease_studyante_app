part of 'teacher_chat_bloc.dart';

class TeacherChatState extends Equatable {
  final ViewStatus viewStatus;
  final ChatModel chatModel;
  final bool isSending;
  final bool isWebSocketConnected;

  const TeacherChatState({
    required this.chatModel,
    this.isSending = false,
    this.isWebSocketConnected = false,
    this.viewStatus = ViewStatus.none,
  });

  TeacherChatState copyWith({
    ViewStatus? viewStatus,
    ChatModel? chatModel,
    bool? isSending,
    bool? isWebSocketConnected,
  }) {
    return TeacherChatState(
      viewStatus: viewStatus ?? this.viewStatus,
      chatModel: chatModel ?? this.chatModel,
      isSending: isSending ?? this.isSending,
      isWebSocketConnected: isWebSocketConnected ?? this.isWebSocketConnected,
    );
  }

  @override
  List<Object> get props => [
        viewStatus,
        chatModel,
        isSending,
        isWebSocketConnected,
      ];
}

final class TeacherChatInitial extends TeacherChatState {
  const TeacherChatInitial({required super.chatModel});
}
