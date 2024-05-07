// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'teacher_chat_bloc.dart';

abstract class TeacherChatEvent extends Equatable {
  const TeacherChatEvent();

  @override
  List<Object?> get props => [];
}

class OnGetInitialChat extends TeacherChatEvent {
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

class OnPaginateChat extends TeacherChatEvent {}
