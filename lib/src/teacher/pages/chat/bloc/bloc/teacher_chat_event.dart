part of 'teacher_chat_bloc.dart';

abstract class TeacherChatEvent extends Equatable {
  const TeacherChatEvent();

  @override
  List<Object> get props => [];
}

class OnGetInitialChat extends TeacherChatEvent {}

class OnTryConnectToWebSocket extends TeacherChatEvent {}

class OnGetConnectWebSocket extends TeacherChatEvent {
  final bool isConnected;

  const OnGetConnectWebSocket({
    required this.isConnected,
  });

  @override
  List<Object> get props => [isConnected];
}

class OnSendChat extends TeacherChatEvent {
  final String message;

  const OnSendChat({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

class OnReceivedMessageChat extends TeacherChatEvent {
  final dynamic message;

  const OnReceivedMessageChat({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
