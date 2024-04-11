part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ViewStatus viewStatus;
  final ChatModel chatModel;
  final bool isSending;
  final bool isWebSocketConnected;

  const ChatState({
    required this.chatModel,
    this.isSending = false,
    this.isWebSocketConnected = false,
    this.viewStatus = ViewStatus.none,
  });

  ChatState copyWith({
    ViewStatus? viewStatus,
    ChatModel? chatModel,
    bool? isSending,
    bool? isWebSocketConnected,
  }) {
    return ChatState(
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

final class ChatInitial extends ChatState {
  const ChatInitial({required super.chatModel});
}
