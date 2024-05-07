part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ViewStatus viewStatus;
  final ChatModel chatModel;
  final ChatSession? chatSession;
  final bool isSending;
  final bool isWebSocketConnected;

  const ChatState({
    required this.chatModel,
    this.chatSession,
    this.isSending = false,
    this.isWebSocketConnected = false,
    this.viewStatus = ViewStatus.none,
  });

  ChatState copyWith({
    ViewStatus? viewStatus,
    ChatModel? chatModel,
    bool? isSending,
    bool? isWebSocketConnected,
    ChatSession? chatSession,
  }) {
    return ChatState(
      viewStatus: viewStatus ?? this.viewStatus,
      chatModel: chatModel ?? this.chatModel,
      isSending: isSending ?? this.isSending,
      isWebSocketConnected: isWebSocketConnected ?? this.isWebSocketConnected,
      chatSession: chatSession ?? this.chatSession,
    );
  }

  @override
  List<Object?> get props => [
        viewStatus,
        chatModel,
        isSending,
        isWebSocketConnected,
        chatSession,
      ];
}

final class ChatInitial extends ChatState {
  const ChatInitial({required super.chatModel});
}
