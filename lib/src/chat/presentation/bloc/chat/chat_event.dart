part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class OnGetInitialChat extends ChatEvent {
  final ChatSession? chatSession;
  final String roomName;
  final String personId;
  final String teacherId;

  const OnGetInitialChat({
    required this.roomName,
    required this.teacherId,
    required this.personId,
    this.chatSession,
  });

  @override
  List<Object?> get props => [
        roomName,
        chatSession,
        personId,
        teacherId,
      ];
}

class OnPaginateChat extends ChatEvent {}

class OnTryConnectToWebSocket extends ChatEvent {}

class OnGetConnectWebSocket extends ChatEvent {
  final bool isConnected;

  const OnGetConnectWebSocket({
    required this.isConnected,
  });

  @override
  List<Object> get props => [isConnected];
}

class OnSendChat extends ChatEvent {
  final String message;

  const OnSendChat({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

class OnReceivedMessageChat extends ChatEvent {
  final dynamic message;

  const OnReceivedMessageChat({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
